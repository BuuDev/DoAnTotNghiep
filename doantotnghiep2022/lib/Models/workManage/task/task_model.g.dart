// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModelDemo _$TaskModelDemoFromJson(Map<String, dynamic> json) =>
    TaskModelDemo(
      id: json['id'] as int,
      work_id: json['work_id'] as int,
      name: json['name'] as String,
      index: json['index'] as int,
      status: json['status'] as int,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      list_task: (json['list_task'] as List<dynamic>)
          .map((e) => TaskItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskModelDemoToJson(TaskModelDemo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'work_id': instance.work_id,
      'name': instance.name,
      'index': instance.index,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'list_task': instance.list_task,
    };
