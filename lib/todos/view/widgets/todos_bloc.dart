import 'package:crud_project/todos/bloc/cubit/todo_cubit.dart';
import 'package:crud_project/todos/riverpod/todos_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosBlocView extends StatefulWidget {
  const TodosBlocView({super.key});

  @override
  State<TodosBlocView> createState() => _TodosBlocViewState();
}

class _TodosBlocViewState extends State<TodosBlocView> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initial load after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoCubit>().loadFirstPage();
    });

    // Infinite scroll listener
    _scrollController.addListener(() {
      final cubit = context.read<TodoCubit>();
      final s = cubit.state;
      if (!_scrollController.hasClients) return;

      final pos = _scrollController.position;
      final nearBottom = pos.pixels >= (pos.maxScrollExtent - 200);
      final hasMore = s.items.length < s.total;

      if (nearBottom && hasMore && !s.isLoading) {
        cubit.loadNextPage();
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
    return BlocListener<TodoCubit, TodosState>(
      listenWhen: (prev, next) => prev.error != next.error,
      listener: (context, state) {
        final err = state.error;
        if (err != null && mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(err)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Todos (BLoC)')),
        body: BlocBuilder<TodoCubit, TodosState>(
          builder: (context, state) {
            final cubit = context.read<TodoCubit>();

            final hasMore = state.items.length < state.total;
            final showTailRow = state.isLoading || !hasMore;

            return RefreshIndicator(
              onRefresh: () => cubit.loadFirstPage(),
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
                        onDismissed: (_) => cubit.remove(todo.id),
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
                                      cubit.toggleComplete(todo.id, v ?? false),
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
                                  onPressed: () => cubit.remove(todo.id),
                                ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final title = await _promptForTitle(context, _textController);
            if (title == null || title.trim().isEmpty) return;

            if (context.mounted) {
              await context.read<TodoCubit>().add(title.trim(), 1);
            }

            if (!mounted) return;
            await _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          child: const Icon(Icons.add),
        ),
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
