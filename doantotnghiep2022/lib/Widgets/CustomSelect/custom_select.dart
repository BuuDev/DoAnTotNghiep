import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:flutter/material.dart';

class CustomSelect extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final IconData icon;
  const CustomSelect({
    Key? key,
    required this.title,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.tertiary, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 14,
                ),
              ),
              Icon(
                icon,
                color: AppColors.textBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
