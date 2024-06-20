// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permissions _$PermissionsFromJson(Map<String, dynamic> json) => Permissions(
      id: json['id'] as int,
      name: json['name'] as String,
      guardName: json['guard_name'] as String,
      createdat: json['created_at'] as String?,
      updatedat: json['updated_at'] as String,
      deletedat: json['deleted_at'] as String,
    );

Map<String, dynamic> _$PermissionsToJson(Permissions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'guard_name': instance.guardName,
      'created_at': instance.createdat,
      'updated_at': instance.updatedat,
      'deleted_at': instance.deletedat,
    };
