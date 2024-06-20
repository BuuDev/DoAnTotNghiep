import 'package:json_annotation/json_annotation.dart';
part 'demo_model.g.dart';

@JsonSerializable()
class DemoModels {
  int userId;
  String title;
  String body;
  int id;

  DemoModels(
      {required this.userId,
      required this.body,
      required this.id,
      required this.title});

  factory DemoModels.fromJson(Map<String, dynamic> json) =>
      _$DemoModelsFromJson(json);

  Map<String, dynamic> toJson() => _$DemoModelsToJson(this);
}
