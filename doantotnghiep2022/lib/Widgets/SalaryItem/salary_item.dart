import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:flutter/material.dart';

class SalaryItem extends StatelessWidget {
  final String title;
  final String money;
  final Function()? action;
  const SalaryItem({
    required this.title,
    required this.money,
    this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textBlack,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Row(
          children: [
            Text(Helper.toMoney(money) + 'đ'),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: action, icon: const Icon(Icons.more_vert_outlined)),
          ],
        ),
      ],
    );
  }
}
