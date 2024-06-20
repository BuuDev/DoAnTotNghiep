import 'package:json_annotation/json_annotation.dart';
part 'response_change_password.g.dart';

@JsonSerializable()
class ResponseChangePassword {
  String message;

  ResponseChangePassword({required this.message});

  factory ResponseChangePassword.fromJson(Map<String, dynamic> json) =>
      _$ResponseChangePasswordFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseChangePasswordToJson(this);
}
