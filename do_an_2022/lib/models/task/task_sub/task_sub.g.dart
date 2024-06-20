// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_sub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskSub _$TaskSubFromJson(Map<String, dynamic> json) => TaskSub(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as int,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$TaskSubToJson(TaskSub instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
