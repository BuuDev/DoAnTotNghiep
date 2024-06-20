// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseUser _$ResponseUserFromJson(Map<String, dynamic> json) => ResponseUser(
      access_token: json['access_token'] as String,
      user: UserDemo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseUserToJson(ResponseUser instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'user': instance.user,
    };
