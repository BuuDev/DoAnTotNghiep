import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'salary_data.g.dart';

@JsonSerializable()
class SalaryData {
  int id;
  double working_day;
  String? salary;
  String? allowance;
  String? total;
  String? advance;
  String? actual_salary;
  String month;
  String status;
  UserDemo? user;
  ContractID? contract;

  String created_at;
  String updated_at;

  SalaryData({
    required this.id,
    required this.working_day,
    required this.salary,
    required this.allowance,
    required this.total,
    required this.advance,
    required this.actual_salary,
    required this.month,
    required this.status,
    required this.user,
    this.contract,
    required this.created_at,
    required this.updated_at,
  });
  double luong() {
    return ((working_day * contract!.salary!) / 22 +
        double.parse(allowance!) -
        double.parse(advance!));
  }

  double tongLuong() {
    return (working_day * contract!.salary!) / 22;
  }

  factory SalaryData.fromJson(Map<String, dynamic> json) =>
      _$SalaryDataFromJson(json);

  Map<String, dynamic> toJson() => _$SalaryDataToJson(this);
}

@JsonSerializable()
class ContractID {
  int id;
  String? code;
  int user_id;
  String? start_date;
  String? finish_date;
  String? signing_date;
  String? content;
  int? salary;
  String created_at;
  String updated_at;

  ContractID({
    required this.id,
    this.code,
    required this.user_id,
    this.start_date,
    this.finish_date,
    this.signing_date,
    this.content,
    this.salary,
    required this.created_at,
    required this.updated_at,
  });

  factory ContractID.fromJson(Map<String, dynamic> json) =>
      _$ContractIDFromJson(json);

  Map<String, dynamic> toJson() => _$ContractIDToJson(this);
}
