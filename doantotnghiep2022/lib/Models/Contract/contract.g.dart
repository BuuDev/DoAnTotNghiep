// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      content: json['content'] as String,
      contractId: json['contract_id'] as int?,
      finishDate: json['finish_date'] as String,
      signingDate: json['signing_date'] as String,
      startDate: json['start_date'] as String,
      salary: json['salary'] as int?,
      count: json['count'] as int,
      user: json['user'] == null
          ? null
          : UserDemo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'start_date': instance.startDate,
      'finish_date': instance.finishDate,
      'signing_date': instance.signingDate,
      'content': instance.content,
      'contract_id': instance.contractId,
      'salary': instance.salary,
      'count': instance.count,
      'user': instance.user,
    };
