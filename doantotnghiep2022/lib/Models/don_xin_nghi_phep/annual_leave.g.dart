// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annual_leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnualLeaveData _$AnnualLeaveDataFromJson(Map<String, dynamic> json) =>
    AnnualLeaveData(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      start_date: json['start_date'] as String,
      finish_date: json['finish_date'] as String,
      total_day: json['total_day'] as int,
      reason_not_approving: json['reason_not_approving'] as String?,
      status: json['status'] as int,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String?,
      user: UserDemo.fromJson(json['user'] as Map<String, dynamic>),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$AnnualLeaveDataToJson(AnnualLeaveData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'start_date': instance.start_date,
      'finish_date': instance.finish_date,
      'total_day': instance.total_day,
      'reason_not_approving': instance.reason_not_approving,
      'reason': instance.reason,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'user': instance.user,
    };
