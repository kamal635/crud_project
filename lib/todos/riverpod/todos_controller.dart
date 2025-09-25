// lib/todos/riverpod/todos_controller.dart
import 'package:crud_project/todos/model/todo.dart';
import 'package:crud_project/todos/repo/todos_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repo/todos_repository.dart';

import 'todos_state.dart';

class TodosController extends Notifier<TodosState> {
  late final TodosRepository _repo;

  @override
  TodosState build() {
    _repo = ref.watch(todosRepositoryProvider);
    return const TodosState();
  }

  Future<void> loadFirstPage() async {
    // Guard: prevent concurrent requests
    if (state.isLoading) return;

    // Prepare initial loading state
    state = state.copyWith(
      isLoading: true,
      error: null,
      skip: 0,
      // items: const [], // uncomment if you want to clear the list during loading
    );

    try {
      // Fetch first page from repository
      final page = await _repo.fetchTodos(limit: state.limit, skip: 0);

      // Success: update state with data & pagination meta
      state = state.copyWith(
        items: page.todos,
        total: page.total,
        skip: page.skip, // server may echo/adjust skip
        limit: page.limit, // server may echo/adjust limit
        isLoading: false,
        error: null,
      );
    } catch (e) {
      // Failure: stop loading and store a readable error
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadNextPage() async {
    // Guard: prevent concurrent requests
    if (state.isLoading) return;

    // Guard: no more items to load
    final hasMore = state.skip + state.items.length < state.total;
    if (!hasMore) return;

    // Compute next offset
    final nextSkip = state.skip + state.items.length;

    // Enter loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Fetch next page
      final page = await _repo.fetchTodos(limit: state.limit, skip: nextSkip);

      // Merge results (immutably) and de-duplicate by id
      final existing = state.items;
      final incoming = page.todos;
      final merged = [
        ...existing,
        ...incoming.where((t) => !existing.any((e) => e.id == t.id)),
      ];

      // Success: update state
      state = state.copyWith(
        items: merged,
        total: page.total,
        skip: nextSkip, // we advanced the offset
        limit: page.limit, // in case server echoes/adjusts it
        isLoading: false,
        error: null,
      );
    } catch (e) {
      // Failure: stop loading and record error
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> add(String title, int userId) async {
    // Optional guard: prevent overlapping mutations if you want
    if (state.isLoading) return;

    // Enter a lightweight "mutation" loading; we reuse isLoading for simplicity
    state = state.copyWith(isLoading: true, error: null);

    try {
      // 1) Call repository to create the todo on server
      final created = await _repo.addTodo(
        title: title,
        userId: userId,
        completed: false,
      );

      // 2) Decide how to insert in the list:
      //    - Prepend (show new items at top) or
      //    - Append (add at bottom)
      // Here we PREPEND so the user immediately sees the new item
      final updatedItems = [created, ...state.items];

      // 3) Optionally bump total by +1 (server total may not be returned by POST)
      final newTotal = state.total + 1;

      // 4) Commit new state (immutably)
      state = state.copyWith(
        items: updatedItems,
        total: newTotal,
        // skip stays the same; we're not changing pagination offset here
        isLoading: false,
        error: null,
      );
    } catch (e) {
      // On failure: clear loading and store error
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> toggleComplete(int id, bool value) async {
    // Find index
    final idx = state.items.indexWhere((t) => t.id == id);
    if (idx == -1) return;

    // Mark this item as mutating
    state = state.copyWith(
      mutatingIds: {...state.mutatingIds, id},
      error: null,
    );

    // Snapshot for revert
    final prevItems = state.items;

    // Optimistic update
    final updated = prevItems[idx].copyWith(completed: value);
    final next = List<Todo>.of(prevItems)..[idx] = updated;
    state = state.copyWith(items: next);

    try {
      // Persist on server; (optionally) replace with server's response
      await _repo.updateTodo(id, completed: value);
    } catch (e) {
      // Revert on failure
      state = state.copyWith(items: prevItems, error: e.toString());
    } finally {
      // Clear per-item loading
      final m = {...state.mutatingIds}..remove(id);
      state = state.copyWith(mutatingIds: m);
    }
  }

  Future<void> remove(int id) async {
    // Find index
    final idx = state.items.indexWhere((t) => t.id == id);
    if (idx == -1) return;

    // Mark item as mutating
    state = state.copyWith(
      mutatingIds: {...state.mutatingIds, id},
      error: null,
    );

    // Snapshots
    final prevItems = state.items;
    final prevTotal = state.total;

    // Optimistic remove
    final next = List<Todo>.of(prevItems)..removeAt(idx);
    state = state.copyWith(
      items: next,
      total: prevTotal > 0 ? prevTotal - 1 : 0,
    );

    try {
      final ok = await _repo.deleteTodo(id);
      if (!ok) {
        // Explicit failure → revert
        state = state.copyWith(
          items: prevItems,
          total: prevTotal,
          error: 'Delete failed',
        );
      }
    } catch (e) {
      // Network/server failure → revert
      state = state.copyWith(
        items: prevItems,
        total: prevTotal,
        error: e.toString(),
      );
    } finally {
      // Clear per-item loading
      final m = {...state.mutatingIds}..remove(id);
      state = state.copyWith(mutatingIds: m);
    }
  }
}

final todosControllerProvider = NotifierProvider<TodosController, TodosState>(
  TodosController.new,
);
