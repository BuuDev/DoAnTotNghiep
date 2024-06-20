// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalaryData _$SalaryDataFromJson(Map<String, dynamic> json) => SalaryData(
      id: json['id'] as int,
      working_day: (json['working_day'] as num).toDouble(),
      salary: json['salary'] as String?,
      allowance: json['allowance'] as String?,
      total: json['total'] as String?,
      advance: json['advance'] as String?,
      actual_salary: json['actual_salary'] as String?,
      month: json['month'] as String,
      status: json['status'] as String,
      user: json['user'] == null
          ? null
          : UserDemo.fromJson(json['user'] as Map<String, dynamic>),
      contract: json['contract'] == null
          ? null
          : ContractID.fromJson(json['contract'] as Map<String, dynamic>),
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$SalaryDataToJson(SalaryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'working_day': instance.working_day,
      'salary': instance.salary,
      'allowance': instance.allowance,
      'total': instance.total,
      'advance': instance.advance,
      'actual_salary': instance.actual_salary,
      'month': instance.month,
      'status': instance.status,
      'user': instance.user,
      'contract': instance.contract,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

ContractID _$ContractIDFromJson(Map<String, dynamic> json) => ContractID(
      id: json['id'] as int,
      code: json['code'] as String?,
      user_id: json['user_id'] as int,
      start_date: json['start_date'] as String?,
      finish_date: json['finish_date'] as String?,
      signing_date: json['signing_date'] as String?,
      content: json['content'] as String?,
      salary: json['salary'] as int?,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$ContractIDToJson(ContractID instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'user_id': instance.user_id,
      'start_date': instance.start_date,
      'finish_date': instance.finish_date,
      'signing_date': instance.signing_date,
      'content': instance.content,
      'salary': instance.salary,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
