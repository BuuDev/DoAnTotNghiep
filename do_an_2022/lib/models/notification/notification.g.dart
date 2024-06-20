// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: json['email'] as int,
      type: json['type'] as String,
      notifiable: json['notifiable'] as String,
      realat: json['real_at'] as int,
      status: json['status'] as int,
      createdat: json['created_at'] as String?,
      deletedat: json['deleted_at'] as String,
      updatedat: json['updated_at'] as String,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'email': instance.id,
      'type': instance.type,
      'notifiable': instance.notifiable,
      'real_at': instance.realat,
      'status': instance.status,
      'created_at': instance.createdat,
      'updated_at': instance.updatedat,
      'deleted_at': instance.deletedat,
    };
