import 'package:json_annotation/json_annotation.dart';
part 'department.g.dart';

@JsonSerializable()
class Department {
  int id;
  String name;
  @JsonKey(name: 'user_id')
  int? userId;

  Department({required this.id, required this.name, this.userId});

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
