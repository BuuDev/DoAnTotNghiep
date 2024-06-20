// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_demo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelDemo _$LevelDemoFromJson(Map<String, dynamic> json) => LevelDemo(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String?,
      status: json['status'] as String?,
      progress: json['progress'] as int?,
      type: json['type'] as String?,
      priority: json['priority'] as String?,
      starting: json['starting'] as String?,
      ending: json['ending'] as String?,
      size: json['size'] as String?,
      rate: json['rate'] as String?,
      detail: json['detail'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      level: (json['level'] as List<dynamic>?)
          ?.map((e) => LevelItemDemo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LevelDemoToJson(LevelDemo instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'status': instance.status,
      'progress': instance.progress,
      'type': instance.type,
      'priority': instance.priority,
      'starting': instance.starting,
      'ending': instance.ending,
      'size': instance.size,
      'rate': instance.rate,
      'detail': instance.detail,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'level': instance.level,
    };
