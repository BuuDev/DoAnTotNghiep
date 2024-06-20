import 'package:doantotnghiep/Models/Contract/contract.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contract_data.g.dart';

@JsonSerializable()
class ContractData {
  @JsonKey(name: 'Contract')
  List<Contract> contract;

  ContractData({required this.contract});

  factory ContractData.fromJson(Map<String, dynamic> json) =>
      _$ContractDataFromJson(json);

  Map<String, dynamic> toJson() => _$ContractDataToJson(this);
}
