// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      birthday: json['birthday'] as String,
      address: json['address'] as String,
      cmnd: json['cmnd'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'phone': instance.phone,
      'cmnd': instance.cmnd,
      'email': instance.email,
      'address': instance.address,
    };
