import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'annual_leave.g.dart';

@JsonSerializable()
class AnnualLeaveData {
  int id;
  int user_id;
  String start_date;
  String finish_date;
  int total_day;
  String? reason_not_approving;
  String? reason;
  int status;
  String created_at;
  String? updated_at;
  UserDemo user;

  AnnualLeaveData({
    required this.id,
    required this.user_id,
    required this.start_date,
    required this.finish_date,
    required this.total_day,
    required this.reason_not_approving,
    required this.status,
    required this.created_at,
    required this.updated_at,
    required this.user,
    this.reason,
  });

  factory AnnualLeaveData.fromJson(Map<String, dynamic> json) =>
      _$AnnualLeaveDataFromJson(json);

  Map<String, dynamic> toJson() => _$AnnualLeaveDataToJson(this);
}
