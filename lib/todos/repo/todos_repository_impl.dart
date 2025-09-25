import 'package:crud_project/api/dio_client.dart';
import 'package:crud_project/api/endpoints.dart';
import 'package:crud_project/todos/model/todo.dart';
import 'package:crud_project/todos/model/todos_page.dart';
import 'package:crud_project/todos/repo/todos_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodosRepositoryImpl implements TodosRepository {
  final Dio dio;

  TodosRepositoryImpl({required this.dio});

  @override
  Future<TodosPage> fetchTodos({required int limit, required int skip}) async {
    final res = await dio.get<Map<String, dynamic>>(
      Urls.todos,
      queryParameters: {'limit': limit, 'skip': skip},
    );

    final status = res.statusCode ?? 0;
    final ok = status >= 200 && status < 300;
    final data = res.data;

    if (ok && data != null) {
      return TodosPage.fromJson(data);
    }

    throw Exception('fetchTodos failed (status: $status)');
  }

  @override
  Future<Todo> getTodo(int id) async {
    final res = await dio.get<Map<String, dynamic>>(Urls.todoById(id));

    final status = res.statusCode ?? 0;
    final ok = status >= 200 && status < 300;
    final data = res.data;

    if (ok && data != null) {
      return Todo.fromJson(data);
    }

    throw Exception('getTodo failed (status: $status)');
  }

  @override
  Future<Todo> addTodo({
    required String title,
    required int userId,
    bool completed = false,
  }) async {
    final res = await dio.post<Map<String, dynamic>>(
      Urls.addTodo,
      data: {'todo': title, 'userId': userId, 'completed': completed},
    );
    final status = res.statusCode ?? 0;
    final ok = status >= 200 && status < 300;
    final data = res.data;
    if (ok && data != null) {
      return Todo.fromJson(data);
    }
    throw Exception('addTodo failed (status: $status)');
  }

  @override
  Future<Todo> updateTodo(int id, {String? title, bool? completed}) async {
    final body = <String, dynamic>{};
    if (title != null) body['todo'] = title;
    if (completed != null) body['completed'] = completed;

    if (body.isEmpty) {
      throw Exception('updateTodo called with no fields to update');
    }

    final res = await dio.patch<Map<String, dynamic>>(
      Urls.todoById(id),
      data: body,
    );

    final status = res.statusCode ?? 0;
    final ok = status >= 200 && status < 300;
    final data = res.data;

    if (ok && data != null) {
      return Todo.fromJson(data);
    }
    throw Exception('updateTodo failed (status: $status)');
  }

  @override
  Future<bool> deleteTodo(int id) async {
    final res = await dio.delete<Map<String, dynamic>>(Urls.todoById(id));

    final status = res.statusCode ?? 0;
    final ok = status >= 200 && status < 300;
    final data = res.data;

    if (ok) {
      if (data != null && data.containsKey('isDeleted')) {
        return (data['isDeleted'] as bool?) ?? true;
      }
      return true;
    }
    throw Exception('deletedTodo failed (status: $status)');
  }

  @override
  Future<TodosPage> searchTodos(
    String query, {
    int limit = 10,
    int skip = 0,
  }) async {
    final res = await dio.get<Map<String, dynamic>>(
      Urls.searchTodos,
      queryParameters: {'q': query, 'limit': limit, 'skip': skip},
    );

    final status = res.statusCode ?? 0;
    final ok = status >= 200 && status < 300;
    final data = res.data;

    if (ok && data != null) {
      return TodosPage.fromJson(data);
    }
    throw Exception('searchTodos failed (status: $status)');
  }

  @override
  Future<TodosPage> userTodos(
    int userId, {
    int limit = 10,
    int skip = 0,
  }) async {
    final res = await dio.get<Map<String, dynamic>>(
      Urls.userTodos(userId),
      queryParameters: {'limit': limit, 'skip': skip},
    );

    final status = res.statusCode ?? 0;
    final ok = status >= 200 && status < 300;
    final data = res.data;

    if (ok && data != null) {
      return TodosPage.fromJson(data);
    }
    throw Exception('userTodos failed (status: $status)');
  }
}

final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TodosRepositoryImpl(dio: dio);
});
