import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String birthday;
  final String gender;
  final String phone;
  final String cmnd;
  final String email;
  final String address;

  User(
      {required this.name,
      required this.birthday,
      required this.address,
      required this.cmnd,
      required this.email,
      required this.gender,
      required this.phone});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
