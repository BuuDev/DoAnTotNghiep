// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDepartment _$ListDepartmentFromJson(Map<String, dynamic> json) =>
    ListDepartment(
      data: (json['data'] as List<dynamic>)
          .map((e) => Department.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDepartmentToJson(ListDepartment instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
