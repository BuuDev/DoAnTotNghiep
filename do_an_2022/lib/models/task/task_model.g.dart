// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      index: json['index'] as int,
      type: json['type'] as String,
      timeOut: DateTime.parse(json['timeOut'] as String),
      status: json['status'] as int,
      levelId: json['level_id'] as int,
      taskImages: (json['task_images'] as List<dynamic>?)
          ?.map((e) => TaskImages.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskAttchaments: (json['task_attachments'] as List<dynamic>?)
          ?.map((e) => TaskAttchaments.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskDetails: (json['task_details'] as List<dynamic>?)
          ?.map((e) => TaskDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskSub: (json['task_sub'] as List<dynamic>?)
          ?.map((e) => TaskSub.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'index': instance.index,
      'type': instance.type,
      'timeOut': instance.timeOut.toIso8601String(),
      'status': instance.status,
      'level_id': instance.levelId,
      'task_images': instance.taskImages,
      'task_attachments': instance.taskAttchaments,
      'task_details': instance.taskDetails,
      'task_sub': instance.taskSub,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
