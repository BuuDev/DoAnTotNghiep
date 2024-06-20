// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'don_xin_nghi_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnualLeave _$AnnualLeaveFromJson(Map<String, dynamic> json) => AnnualLeave(
      success: json['success'] as bool,
      message: json['message'] as String,
      users: (json['users'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      annual_leave: (json['annual_leave'] as List<dynamic>)
          .map((e) => AnnualLeaveData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnnualLeaveToJson(AnnualLeave instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'users': instance.users,
      'annual_leave': instance.annual_leave,
    };
