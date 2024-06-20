// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_search_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSearchUser _$ResponseSearchUserFromJson(Map<String, dynamic> json) =>
    ResponseSearchUser(
      user: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseSearchUserToJson(ResponseSearchUser instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
