// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_priority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskPriority _$TaskPriorityFromJson(Map<String, dynamic> json) => TaskPriority(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      status: json['status'] as int,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$TaskPriorityToJson(TaskPriority instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
