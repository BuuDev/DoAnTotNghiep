// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Approve _$ApproveFromJson(Map<String, dynamic> json) => Approve(
      message: json['message'] as String,
      data: ApproveData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$ApproveToJson(Approve instance) => <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };
