// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkResponse _$WorkResponseFromJson(Map<String, dynamic> json) => WorkResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WorkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkResponseToJson(WorkResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
