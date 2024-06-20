import 'package:json_annotation/json_annotation.dart';
part 'province.g.dart';

@JsonSerializable()
class Province {
  String idProvince;
  String name;

  Province({required this.idProvince, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}
