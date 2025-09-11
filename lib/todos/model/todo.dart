import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required int id,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'todo')
    required String title, // API key "todo" → model "title"
    required bool completed,
    required int userId,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
