// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'don_xin_nghi_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int,
      code: json['code'] as String?,
      fullname: json['fullname'] as String?,
      username: json['username'] as String?,
      birthday: json['birthday'] as String?,
      citizen_identification: json['citizen_identification'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String?,
      deleted_at: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'fullname': instance.fullname,
      'username': instance.username,
      'birthday': instance.birthday,
      'citizen_identification': instance.citizen_identification,
      'avatar': instance.avatar,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_at': instance.deleted_at,
    };
