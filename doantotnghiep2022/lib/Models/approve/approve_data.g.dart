// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveData _$ApproveDataFromJson(Map<String, dynamic> json) => ApproveData(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      start_date: json['start_date'] as String,
      total_day: json['total_day'] as int,
      finish_date: json['finish_date'] as String,
      status: json['status'] as int,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$ApproveDataToJson(ApproveData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'start_date': instance.start_date,
      'finish_date': instance.finish_date,
      'total_day': instance.total_day,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
