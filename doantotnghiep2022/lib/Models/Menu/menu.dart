import 'package:json_annotation/json_annotation.dart';
part 'menu.g.dart';

@JsonSerializable()
class Menu {
  String title;
  String? icon;
  String? backgroundColor;

  Menu({
    required this.title,
    this.icon,
    this.backgroundColor,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
