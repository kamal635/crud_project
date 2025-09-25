import 'package:crud_project/todos/model/todo.dart';
import 'package:crud_project/todos/repo/todos_repository.dart';
import 'package:crud_project/todos/riverpod/todos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodosState> {
  TodoCubit(this._repo) : super(const TodosState());
  final TodosRepository _repo;

  Future<void> loadFirstPage() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null, skip: 0));

    try {
      final page = await _repo.fetchTodos(limit: state.limit, skip: 0);
      emit(
        state.copyWith(
          items: page.todos,
          total: page.total,
          skip: page.skip,
          limit: page.limit,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoading) return;
    final hasMore = state.items.length < state.total;
    if (!hasMore) return;

    final nextSkip = state.items.length;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final page = await _repo.fetchTodos(limit: state.limit, skip: nextSkip);

      final existing = state.items;
      final incoming = page.todos;
      final merged = [
        ...existing,
        ...incoming.where(
          (newItem) => !existing.any((e) => e.id == newItem.id),
        ),
      ];
      emit(
        state.copyWith(
          items: merged,
          total: page.total,
          skip: nextSkip,
          limit: page.limit,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> add(String title, int userId) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final newTodo = await _repo.addTodo(title: title.trim(), userId: userId);
      final newItems = [newTodo, ...state.items];
      final newTotal = state.total + 1;

      emit(
        state.copyWith(
          items: newItems,
          total: newTotal,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> toggleComplete(int id, bool value) async {
    final idx = state.items.indexWhere((t) => t.id == id);
    if (idx == -1) return;

    emit(state.copyWith(mutatingIds: {...state.mutatingIds, id}, error: null));

    final oldItems = state.items;

    final updated = oldItems[idx].copyWith(completed: value);
    final next = List<Todo>.of(oldItems)..[idx] = updated;
    emit(state.copyWith(items: next));

    try {
      await _repo.updateTodo(id, completed: value);
    } catch (e) {
      emit(state.copyWith(items: oldItems, error: e.toString()));
    } finally {
      final m = {...state.mutatingIds}..remove(id);
      emit(state.copyWith(mutatingIds: m));
    }
  }

  Future<void> remove(int id) async {
    final idx = state.items.indexWhere((t) => t.id == id);
    if (idx == -1) return;

    emit(state.copyWith(mutatingIds: {...state.mutatingIds, id}, error: null));

    final prevItems = state.items;
    final prevTotal = state.total;

    final nextItems = List<Todo>.of(prevItems)..removeAt(idx);
    final nextTotal = prevTotal > 0 ? prevTotal - 1 : 0;
    emit(state.copyWith(items: nextItems, total: nextTotal));

    try {
      final ok = await _repo.deleteTodo(id);
      if (!ok) {
        emit(
          state.copyWith(
            items: prevItems,
            total: prevTotal,
            error: 'Delete failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(items: prevItems, total: prevTotal, error: e.toString()),
      );
    } finally {
      final m = {...state.mutatingIds}..remove(id);
      emit(state.copyWith(mutatingIds: m));
    }
  }
}
