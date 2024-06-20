import 'package:json_annotation/json_annotation.dart';

import 'level_demo.dart';
part 'level_response.g.dart';

@JsonSerializable()
class LevelResponse {
  bool success;
  String message;
  LevelDemo? data;

  LevelResponse({
    required this.success,
    required this.message,
    required this.data,
  });
  @override
  String toString() {
    return toJson().toString();
  }

  factory LevelResponse.fromJson(Map<String, dynamic> json) =>
      _$LevelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LevelResponseToJson(this);
}
