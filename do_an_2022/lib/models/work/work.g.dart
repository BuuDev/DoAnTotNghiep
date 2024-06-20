// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkModel _$WorkModelFromJson(Map<String, dynamic> json) => WorkModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      status: json['status'] as String?,
      type: json['type'] as String?,
      priority: json['priority'] as String?,
      starting: json['starting'] == null
          ? null
          : DateTime.parse(json['starting'] as String),
      ending: json['ending'] == null
          ? null
          : DateTime.parse(json['ending'] as String),
      size: json['size'] as String?,
      rate: json['rate'] as String?,
      detail: json['detail'] as String?,
      background: json['background'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$WorkModelToJson(WorkModel instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'status': instance.status,
      'type': instance.type,
      'priority': instance.priority,
      'starting': instance.starting?.toIso8601String(),
      'ending': instance.ending?.toIso8601String(),
      'size': instance.size,
      'rate': instance.rate,
      'detail': instance.detail,
      'background': instance.background,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
