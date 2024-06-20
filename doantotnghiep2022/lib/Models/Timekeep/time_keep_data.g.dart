// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_keep_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeKeepData _$TimeKeepDataFromJson(Map<String, dynamic> json) => TimeKeepData(
      id: json['id'] as int?,
      user_id: json['user_id'] as int,
      checkin: json['checkin'] as String?,
      checkout: json['checkout'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      user: json['user'] == null
          ? null
          : UserDemo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimeKeepDataToJson(TimeKeepData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'checkin': instance.checkin,
      'checkout': instance.checkout,
      'date': instance.date,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'user': instance.user,
    };
