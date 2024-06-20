// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_keep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeKeepResponse _$TimeKeepResponseFromJson(Map<String, dynamic> json) =>
    TimeKeepResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: TimeKep.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimeKeepResponseToJson(TimeKeepResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

TimeKep _$TimeKepFromJson(Map<String, dynamic> json) => TimeKep(
      Timesheet: (json['Timesheet'] as List<dynamic>?)
          ?.map((e) => TimeKeepData.fromJson(e as Map<String, dynamic>))
          .toList(),
      AnnualLeave: (json['AnnualLeave'] as List<dynamic>?)
          ?.map((e) => Annual.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeKepToJson(TimeKep instance) => <String, dynamic>{
      'Timesheet': instance.Timesheet,
      'AnnualLeave': instance.AnnualLeave,
    };

Annual _$AnnualFromJson(Map<String, dynamic> json) => Annual(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      start_date: json['start_date'] as String,
      finish_date: json['finish_date'] as String,
      total_day: json['total_day'] as int,
      reason_not_approving: json['reason_not_approving'] as String?,
      status: json['status'] as int,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$AnnualToJson(Annual instance) => <String, dynamic>{
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
    };
