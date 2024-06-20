// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItemModel _$TaskItemModelFromJson(Map<String, dynamic> json) =>
    TaskItemModel(
      id: json['id'] as int,
      title: json['title'] as String?,
      content: json['content'] as String?,
      index: json['index'] as int?,
      type: json['type'] as String?,
      timeOut: json['timeOut'] as String?,
      status: json['status'] as int?,
      assign: (json['assign'] as List<dynamic>?)
          ?.map((e) => TaskAssign.fromJson(e as Map<String, dynamic>))
          .toList(),
      attchaments: (json['attchaments'] as List<dynamic>?)
          ?.map((e) => TaskAttchaments.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: (json['comment'] as List<dynamic>?)
          ?.map((e) => TaskComment.fromJson(e as Map<String, dynamic>))
          .toList(),
      completeAt: json['complete_at'] as String?,
      level_id: json['level_id'] as int,
      priority_id: json['priority_id'] as int?,
      priority: json['priority'] == null
          ? null
          : TaskPriority.fromJson(json['priority'] as Map<String, dynamic>),
      timeStart: json['timeStart'] as String?,
      user_id: json['user_id'] as int,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$TaskItemModelToJson(TaskItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level_id': instance.level_id,
      'user_id': instance.user_id,
      'title': instance.title,
      'content': instance.content,
      'index': instance.index,
      'type': instance.type,
      'timeOut': instance.timeOut,
      'timeStart': instance.timeStart,
      'priority_id': instance.priority_id,
      'status': instance.status,
      'complete_at': instance.completeAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'assign': instance.assign,
      'priority': instance.priority,
      'attchaments': instance.attchaments,
      'comment': instance.comment,
    };
