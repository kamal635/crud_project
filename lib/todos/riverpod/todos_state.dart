// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/todo.dart';

part 'todos_state.freezed.dart';

@freezed
abstract class TodosState with _$TodosState {
  const factory TodosState({
    @Default(<Todo>[]) List<Todo> items,
    @Default(0) int total,
    @Default(0) int skip,
    @Default(20) int limit,
    @Default(false) bool isLoading,
    @Default(<int>{}) Set<int> mutatingIds, // per-item loading marker
    String? error,
  }) = _TodosState;
}
