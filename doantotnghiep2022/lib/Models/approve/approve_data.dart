import 'package:json_annotation/json_annotation.dart';
part 'approve_data.g.dart';

@JsonSerializable()
class ApproveData {
  int id;
  int user_id;
  String start_date;
  String finish_date;
  int total_day;

  int status;
  String created_at;
  String updated_at;

  ApproveData({
    required this.id,
    required this.user_id,
    required this.start_date,
    required this.total_day,
    required this.finish_date,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory ApproveData.fromJson(Map<String, dynamic> json) =>
      _$ApproveDataFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveDataToJson(this);
}
