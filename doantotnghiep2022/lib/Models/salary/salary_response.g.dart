// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalaryResponse _$SalaryResponseFromJson(Map<String, dynamic> json) =>
    SalaryResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => SalaryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$SalaryResponseToJson(SalaryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
