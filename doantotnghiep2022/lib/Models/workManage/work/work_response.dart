import 'package:doantotnghiep/Models/workManage/work/work.dart';
import 'package:json_annotation/json_annotation.dart';
part 'work_response.g.dart';

@JsonSerializable()
class WorkResponse {
  bool success;
  String message;
  List<WorkModel>? data;

  WorkResponse({
    required this.success,
    required this.message,
    required this.data,
  });
  @override
  String toString() {
    return toJson().toString();
  }

  factory WorkResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkResponseToJson(this);
}
