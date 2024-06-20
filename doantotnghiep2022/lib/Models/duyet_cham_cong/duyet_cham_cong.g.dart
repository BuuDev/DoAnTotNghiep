// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duyet_cham_cong.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveTimeKeep _$ApproveTimeKeepFromJson(Map<String, dynamic> json) =>
    ApproveTimeKeep(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: DataApprove.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApproveTimeKeepToJson(ApproveTimeKeep instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

DataApprove _$DataApproveFromJson(Map<String, dynamic> json) => DataApprove(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      checkin: json['checkin'] as String,
      checkout: json['checkout'] as String,
      date: json['date'] as String,
      status: json['status'] as int,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$DataApproveToJson(DataApprove instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'checkin': instance.checkin,
      'checkout': instance.checkout,
      'date': instance.date,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
