import 'package:doantotnghiep/Models/Timekeep/time_keep_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'time_keep.g.dart';

@JsonSerializable()
class TimeKeepResponse {
  bool success;
  String message;
  TimeKep data;

  TimeKeepResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TimeKeepResponse.fromJson(Map<String, dynamic> json) =>
      _$TimeKeepResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TimeKeepResponseToJson(this);
}

@JsonSerializable()
class TimeKep {
  List<TimeKeepData>? Timesheet;
  List<Annual>? AnnualLeave;

  TimeKep({
    required this.Timesheet,
    this.AnnualLeave,
  });

  factory TimeKep.fromJson(Map<String, dynamic> json) =>
      _$TimeKepFromJson(json);

  Map<String, dynamic> toJson() => _$TimeKepToJson(this);
}

@JsonSerializable()
class Annual {
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

  Annual({
    required this.id,
    required this.user_id,
    required this.start_date,
    required this.finish_date,
    required this.total_day,
    required this.reason_not_approving,
    required this.status,
    required this.created_at,
    required this.updated_at,
    this.reason,
  });

  factory Annual.fromJson(Map<String, dynamic> json) => _$AnnualFromJson(json);

  Map<String, dynamic> toJson() => _$AnnualToJson(this);
}
