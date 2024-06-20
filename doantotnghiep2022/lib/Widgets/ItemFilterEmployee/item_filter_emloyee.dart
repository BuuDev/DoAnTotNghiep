import 'package:flutter/material.dart';

class ItemFilterEmployee extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Function()? onTap;
  final Color? color;
  const ItemFilterEmployee({
    this.icon,
    required this.title,
    this.onTap,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
