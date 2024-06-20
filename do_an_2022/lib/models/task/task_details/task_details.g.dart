// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDetails _$TaskDetailsFromJson(Map<String, dynamic> json) => TaskDetails(
      id: json['id'] as int,
      description: json['description'] as String,
      assignee: json['assignee'] as int,
      reporter: json['reporter'] as int,
      lable: json['lable'] as String,
      priorityId: json['priority_id'] as int,
      status: json['status'] as int,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$TaskDetailsToJson(TaskDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'assignee': instance.assignee,
      'reporter': instance.reporter,
      'lable': instance.lable,
      'priority_id': instance.priorityId,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
