// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Todo _$TodoFromJson(Map<String, dynamic> json) => _Todo(
  id: (json['id'] as num).toInt(),
  title: json['todo'] as String,
  completed: json['completed'] as bool,
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$TodoToJson(_Todo instance) => <String, dynamic>{
  'id': instance.id,
  'todo': instance.title,
  'completed': instance.completed,
  'userId': instance.userId,
};
