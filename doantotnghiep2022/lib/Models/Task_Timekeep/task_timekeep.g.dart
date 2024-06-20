// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_timekeep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskTimeKeep _$TaskTimeKeepFromJson(Map<String, dynamic> json) => TaskTimeKeep(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => TaskTimeKeepData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskTimeKeepToJson(TaskTimeKeep instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

TaskTimeKeepData _$TaskTimeKeepDataFromJson(Map<String, dynamic> json) =>
    TaskTimeKeepData(
      id: json['id'] as int,
      level_id: json['level_id'] as int,
      user_id: json['user_id'] as int,
      timeOut: json['timeOut'] as String?,
      timeStart: json['timeStart'] as String?,
      title: json['title'] as String,
      type: json['type'] as String,
      priority_id: json['priority_id'] as int,
      status: json['status'] as int,
      complete_at: json['complete_at'] as String,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      index: json['index'] as int,
    );

Map<String, dynamic> _$TaskTimeKeepDataToJson(TaskTimeKeepData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level_id': instance.level_id,
      'user_id': instance.user_id,
      'title': instance.title,
      'content': instance.content,
      'index': instance.index,
      'type': instance.type,
      'timeStart': instance.timeStart,
      'timeOut': instance.timeOut,
      'priority_id': instance.priority_id,
      'status': instance.status,
      'complete_at': instance.complete_at,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
