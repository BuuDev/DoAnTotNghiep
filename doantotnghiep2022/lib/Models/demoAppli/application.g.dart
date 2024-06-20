// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemoApplication _$DemoApplicationFromJson(Map<String, dynamic> json) =>
    DemoApplication(
      avatar: json['avatar'] as String,
      name: json['name'] as String,
      end: json['end'] as String,
      start: json['start'] as String,
      ngayNghi: json['ngayNghi'] as int,
      lyDo: json['lyDo'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$DemoApplicationToJson(DemoApplication instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'name': instance.name,
      'start': instance.start,
      'end': instance.end,
      'ngayNghi': instance.ngayNghi,
      'lyDo': instance.lyDo,
      'status': instance.status,
    };
