import 'package:flutter/material.dart';

class ActionItemEmployee extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Color? color;
  final Function()? onTap;
  const ActionItemEmployee({
    required this.title,
    this.icon,
    this.color,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(0),
      title: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: color,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
