abstract class Urls {
  static const base = 'https://dummyjson.com';

  static const todos = '/todos';
  static const addTodo = '/todos/add';
  static const searchTodos = '/todos/search';

  static String todoById(int id) => '/todos/$id';
  static String userTodos(int userId) => '/todos/user/$userId';
}
