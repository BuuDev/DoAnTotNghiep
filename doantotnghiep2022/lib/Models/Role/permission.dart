import 'package:json_annotation/json_annotation.dart';
part 'permission.g.dart';

@JsonSerializable()
class Permisstion {
  int id;
  String name;

  Permisstion({required this.id, required this.name});

  factory Permisstion.fromJson(Map<String, dynamic> json) =>
      _$PermisstionFromJson(json);

  Map<String, dynamic> toJson() => _$PermisstionToJson(this);
}
