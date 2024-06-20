import 'package:json_annotation/json_annotation.dart';
part 'assign.g.dart';

@JsonSerializable()
class ResponseAssign {
  String message;

  ResponseAssign({required this.message});

  factory ResponseAssign.fromJson(Map<String, dynamic> json) =>
      _$ResponseAssignFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseAssignToJson(this);
}
