// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemoModels _$DemoModelsFromJson(Map<String, dynamic> json) => DemoModels(
      userId: json['userId'] as int,
      body: json['body'] as String,
      id: json['id'] as int,
      title: json['title'] as String,
    );

Map<String, dynamic> _$DemoModelsToJson(DemoModels instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'body': instance.body,
      'id': instance.id,
    };
