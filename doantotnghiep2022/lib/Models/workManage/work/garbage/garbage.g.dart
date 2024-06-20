// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garbage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GarbageModelResponse _$GarbageModelResponseFromJson(
        Map<String, dynamic> json) =>
    GarbageModelResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TaskItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GarbageModelResponseToJson(
        GarbageModelResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
