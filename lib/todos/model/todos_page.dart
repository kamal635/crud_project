import 'package:freezed_annotation/freezed_annotation.dart';
import 'todo.dart';

part 'todos_page.freezed.dart';
part 'todos_page.g.dart';

@freezed
abstract class TodosPage with _$TodosPage {
  const factory TodosPage({
    @Default(<Todo>[]) List<Todo> todos,
    required int total,
    required int skip,
    required int limit,
  }) = _TodosPage;

  factory TodosPage.fromJson(Map<String, dynamic> json) =>
      _$TodosPageFromJson(json);
}
