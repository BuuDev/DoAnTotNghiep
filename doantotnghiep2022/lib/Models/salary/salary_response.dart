import 'package:doantotnghiep/Models/salary/salary_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'salary_response.g.dart';

@JsonSerializable()
class SalaryResponse {
  bool success;
  String message;
  List<SalaryData> data;

  SalaryResponse(
      {required this.data, required this.success, required this.message});

  factory SalaryResponse.fromJson(Map<String, dynamic> json) =>
      _$SalaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalaryResponseToJson(this);
}
