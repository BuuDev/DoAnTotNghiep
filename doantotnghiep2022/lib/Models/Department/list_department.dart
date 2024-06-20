import 'package:doantotnghiep/Models/Department/department.dart';
import 'package:json_annotation/json_annotation.dart';
part 'list_department.g.dart';

@JsonSerializable()
class ListDepartment {
  List<Department> data;

  ListDepartment({required this.data});

  factory ListDepartment.fromJson(Map<String, dynamic> json) =>
      _$ListDepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$ListDepartmentToJson(this);
}
