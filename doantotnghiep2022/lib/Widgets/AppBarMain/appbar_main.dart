import 'package:flutter/material.dart';

AppBar appBarMain(Widget? avatar, Widget title, Color? color,
    {Function()? onTap, Widget? leading}) {
  return AppBar(
    backgroundColor: color,
    elevation: 0.5,
    title: title,
    centerTitle: true,
    leading: leading,
    actions: [
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: avatar,
        ),
      ),
    ],
  );
}
