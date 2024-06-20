// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_attchaments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskAttchaments _$TaskAttchamentsFromJson(Map<String, dynamic> json) =>
    TaskAttchaments(
      id: json['id'] as int,
      task_id: json['task_id'] as int,
      user_id: json['user_id'] as int,
      url: json['url'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      status: json['status'] as int,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$TaskAttchamentsToJson(TaskAttchaments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.task_id,
      'user_id': instance.user_id,
      'url': instance.url,
      'type': instance.type,
      'name': instance.name,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
