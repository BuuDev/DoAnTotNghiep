import 'package:doantotnghiep/Models/approve/approve_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'approve.g.dart';

@JsonSerializable()
class Approve {
  String message;
  bool success;
  ApproveData data;

  Approve({required this.message, required this.data, required this.success});

  factory Approve.fromJson(Map<String, dynamic> json) =>
      _$ApproveFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveToJson(this);
}
