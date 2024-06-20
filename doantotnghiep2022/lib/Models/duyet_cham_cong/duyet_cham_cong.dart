import 'package:json_annotation/json_annotation.dart';
part 'duyet_cham_cong.g.dart';

@JsonSerializable()
class ApproveTimeKeep {
  bool success;
  String message;
  DataApprove data;

  ApproveTimeKeep(
      {required this.success, required this.message, required this.data});

  factory ApproveTimeKeep.fromJson(Map<String, dynamic> json) =>
      _$ApproveTimeKeepFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveTimeKeepToJson(this);
}

@JsonSerializable()
class DataApprove {
  int id;
  int user_id;
  String checkin;
  String checkout;
  String date;
  int status;
  String created_at;
  String updated_at;

  DataApprove({
    required this.id,
    required this.user_id,
    required this.checkin,
    required this.checkout,
    required this.date,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory DataApprove.fromJson(Map<String, dynamic> json) =>
      _$DataApproveFromJson(json);

  Map<String, dynamic> toJson() => _$DataApproveToJson(this);
}
