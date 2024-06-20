import 'package:doantotnghiep/Models/don_xin_nghi_phep/annual_leave.dart';
import 'package:doantotnghiep/Models/don_xin_nghi_phep/don_xin_nghi_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'don_xin_nghi_reponse.g.dart';

@JsonSerializable()
class AnnualLeave {
  bool success;
  String message;
  List<Data> users;
  List<AnnualLeaveData> annual_leave;

  AnnualLeave({
    required this.success,
    required this.message,
    required this.users,
    required this.annual_leave,
  });

  factory AnnualLeave.fromJson(Map<String, dynamic> json) =>
      _$AnnualLeaveFromJson(json);

  Map<String, dynamic> toJson() => _$AnnualLeaveToJson(this);
}
