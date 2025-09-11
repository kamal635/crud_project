// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodosPage _$TodosPageFromJson(Map<String, dynamic> json) => _TodosPage(
  todos:
      (json['todos'] as List<dynamic>?)
          ?.map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Todo>[],
  total: (json['total'] as num).toInt(),
  skip: (json['skip'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$TodosPageToJson(_TodosPage instance) =>
    <String, dynamic>{
      'todos': instance.todos,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };
