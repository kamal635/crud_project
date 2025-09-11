import 'dart:async';

import '../model/todo.dart';
import '../model/todos_page.dart';

/// Contract only — no implementation yet.
abstract class TodosRepository {
  /// GET /todos?limit=&skip=
  Future<TodosPage> fetchTodos({required int limit, required int skip});

  /// GET /todos/{id}
  Future<Todo> getTodo(int id);

  /// POST /todos/add
  Future<Todo> addTodo({
    required String title,
    required int userId,
    bool completed = false,
  });

  /// PUT|PATCH /todos/{id}
  Future<Todo> updateTodo(int id, {String? title, bool? completed});

  /// DELETE /todos/{id}
  Future<bool> deleteTodo(int id);

  /// GET /todos/search?q=
  Future<TodosPage> searchTodos(String query, {int limit = 10, int skip = 0});

  /// GET /todos/user/{userId}?limit=&skip=
  Future<TodosPage> userTodos(int userId, {int limit = 10, int skip = 0});
}
