// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_noti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteResponse _$DeleteResponseFromJson(Map<String, dynamic> json) =>
    DeleteResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as int,
    );

Map<String, dynamic> _$DeleteResponseToJson(DeleteResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
