// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_assign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskAssign _$TaskAssignFromJson(Map<String, dynamic> json) => TaskAssign(
      id: json['id'] as int,
      user_id: json['user_id'] as int?,
      status: json['status'] as int?,
      tast_id: json['tast_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$TaskAssignToJson(TaskAssign instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'tast_id': instance.tast_id,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
