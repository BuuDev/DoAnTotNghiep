import 'package:json_annotation/json_annotation.dart';
part 'application.g.dart';

@JsonSerializable()
class DemoApplication {
  String avatar;
  String name;
  String start;
  String end;
  int ngayNghi;
  String lyDo;
  int status;

  DemoApplication(
      {required this.avatar,
      required this.name,
      required this.end,
      required this.start,
      required this.ngayNghi,
      required this.lyDo,
      required this.status});

  factory DemoApplication.fromJson(Map<String, dynamic> json) =>
      _$DemoApplicationFromJson(json);

  Map<String, dynamic> toJson() => _$DemoApplicationToJson(this);
}
