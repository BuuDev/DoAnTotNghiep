// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelResponse _$LevelResponseFromJson(Map<String, dynamic> json) =>
    LevelResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : LevelDemo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LevelResponseToJson(LevelResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
