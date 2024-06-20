import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contract.g.dart';

@JsonSerializable()
class Contract {
  int id;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'start_date')
  String startDate;
  @JsonKey(name: 'finish_date')
  String finishDate;
  @JsonKey(name: 'signing_date')
  String signingDate;
  String content;
  @JsonKey(name: 'contract_id')
  int? contractId;
  int? salary;
  int count;
  UserDemo? user;
  Contract(
      {required this.id,
      required this.userId,
      required this.content,
      this.contractId,
      required this.finishDate,
      required this.signingDate,
      required this.startDate,
      this.salary,
      required this.count,
      required this.user});

  factory Contract.fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);

  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
