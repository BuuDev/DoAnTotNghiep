import 'package:flutter/material.dart';

class DepartmentItem extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Function()? onTap2;
  const DepartmentItem({
    required this.title,
    this.onTap,
    this.onTap2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 211, 210, 210),
            offset: Offset(0, -1),
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: onTap2,
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                )),
            IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.more_vert_outlined,
                )),
          ],
        ),
      ),
    );
  }
}
