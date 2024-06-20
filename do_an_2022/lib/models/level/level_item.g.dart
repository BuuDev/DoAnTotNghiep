// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelItem _$LevelItemFromJson(Map<String, dynamic> json) => LevelItem(
      id: json['id'] as int,
      listTask: (json['listTask'] as List<dynamic>?)
          ?.map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LevelItemToJson(LevelItem instance) => <String, dynamic>{
      'id': instance.id,
      'listTask': instance.listTask,
    };
