// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractData _$ContractDataFromJson(Map<String, dynamic> json) => ContractData(
      contract: (json['Contract'] as List<dynamic>)
          .map((e) => Contract.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContractDataToJson(ContractData instance) =>
    <String, dynamic>{
      'Contract': instance.contract,
    };
