import 'package:crud_project/todos/riverpod/todos_controller.dart';
import 'package:crud_project/todos/riverpod/todos_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodosRiverpodView extends ConsumerStatefulWidget {
  const TodosRiverpodView({super.key});

  @override
  ConsumerState<TodosRiverpodView> createState() => _TodosRiverpodViewState();
}

class _TodosRiverpodViewState extends ConsumerState<TodosRiverpodView> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initial load after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(todosControllerProvider.notifier).loadFirstPage();
    });

    // Infinite scroll listener (guarded by hasMore and !isLoading in build)
    _scrollController.addListener(() {
      final s = ref.read(todosControllerProvider);
      final pos = _scrollController.position;
      final nearBottom = pos.pixels >= pos.maxScrollExtent - 200;
      final hasMore = s.skip + s.items.length < s.total;

      if (nearBottom && hasMore && !s.isLoading) {
        ref.read(todosControllerProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen inside build (allowed)
    ref.listen<TodosState>(todosControllerProvider, (prev, next) {
      final err = next.error;
      if (err != null && err != prev?.error && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(err)));
      }
    });

    final state = ref.watch(todosControllerProvider);
    final ctrl = ref.read(todosControllerProvider.notifier);

    final hasMore = state.skip + state.items.length < state.total;
    final showTailRow = state.isLoading || !hasMore;

    return Scaffold(
      appBar: AppBar(title: const Text('Todos (Riverpod)')),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ctrl.loadFirstPage(),
              child: Builder(
                builder: (_) {
                  // Empty states
                  if (state.items.isEmpty && state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.items.isEmpty && !state.isLoading) {
                    return const Center(child: Text('No todos yet'));
                  }

                  final itemCount = state.items.length + (showTailRow ? 1 : 0);
                  return ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 96, top: 8),
                    itemCount: itemCount,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      // Tail row (loader or "No more")
                      if (index >= state.items.length) {
                        if (state.isLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: Text('No more items')),
                        );
                      }

                      final todo = state.items[index];
                      final mutating = state.mutatingIds.contains(todo.id);

                      return Dismissible(
                        key: ValueKey(todo.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => ctrl.remove(todo.id),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          title: Text(todo.title),
                          subtitle: Text(
                            'ID: ${todo.id} • User: ${todo.userId}',
                          ),
                          leading: Checkbox(
                            value: todo.completed,
                            onChanged: mutating
                                ? null
                                : (v) =>
                                      ctrl.toggleComplete(todo.id, v ?? false),
                          ),
                          trailing: mutating
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => ctrl.remove(todo.id),
                                ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await _promptForTitle(context, _textController);
          if (title == null || title.trim().isEmpty) return;

          await ctrl.add(title.trim(), 1); // Dummy userId for training

          // Optional: scroll to top to reveal newly prepended item
          if (mounted) {
            await _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<String?> _promptForTitle(
  BuildContext context,
  TextEditingController controller,
) async {
  controller.clear();
  return showDialog<String>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Title'),
          onSubmitted: (_) => Navigator.of(ctx).pop(controller.text),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text),
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
