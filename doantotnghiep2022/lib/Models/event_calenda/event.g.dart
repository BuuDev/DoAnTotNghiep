// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      type: json['type'] as String,
      date: json['date'] as String,
      event_name: (json['event_name'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      companyId: json['companyId'] as int,
      checkin: json['checkin'] as String?,
      checkout: json['checkout'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'date': instance.date,
      'event_name': instance.event_name,
      'checkout': instance.checkout,
      'checkin': instance.checkin,
      'companyId': instance.companyId,
    };
