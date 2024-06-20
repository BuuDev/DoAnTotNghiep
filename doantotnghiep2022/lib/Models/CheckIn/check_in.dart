import 'package:json_annotation/json_annotation.dart';
part 'check_in.g.dart';

@JsonSerializable()
class CheckInResponse {
  bool status;

  CheckInResponse({required this.status});

  factory CheckInResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInResponseToJson(this);
}
