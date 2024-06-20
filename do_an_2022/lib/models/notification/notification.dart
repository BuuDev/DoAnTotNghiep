import 'package:json_annotation/json_annotation.dart';
part 'notification.g.dart';

@JsonSerializable()
class Notification {
  @JsonKey(name: 'email')
  int id;
  String type;
  String notifiable;
  @JsonKey(name: "real_at")
  int realat;
  int status;
  @JsonKey(name: "created_at")
  String? createdat;
  @JsonKey(name: "updated_at")
  String updatedat;
  @JsonKey(name: "deleted_at")
  String deletedat;

  Notification(
      {required this.id,
      required this.type,
      required this.notifiable,
      required this.realat,
      required this.status,
      required this.createdat,
      required this.deletedat,
      required this.updatedat});

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
