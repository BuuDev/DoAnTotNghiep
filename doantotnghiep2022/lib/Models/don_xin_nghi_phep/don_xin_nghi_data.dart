import 'package:json_annotation/json_annotation.dart';
part 'don_xin_nghi_data.g.dart';

@JsonSerializable()
class Data {
  int id;
  String? code;
  String? fullname;
  String? username;
  String? birthday;
  String? citizen_identification;
  String? avatar;
  String? email;
  String? phone;
  String? address;

  String created_at;
  String? updated_at;
  String? deleted_at;

  Data({
    required this.id,
    this.code,
    required this.fullname,
    required this.username,
    required this.birthday,
    required this.citizen_identification,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.address,
    required this.created_at,
    this.updated_at,
    this.deleted_at,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
