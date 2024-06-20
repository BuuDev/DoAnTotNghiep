import 'package:json_annotation/json_annotation.dart';
part 'delete_noti.g.dart';

@JsonSerializable()
class DeleteResponse {
  bool success;
  String message;
  int data;

  DeleteResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteResponseToJson(this);
}