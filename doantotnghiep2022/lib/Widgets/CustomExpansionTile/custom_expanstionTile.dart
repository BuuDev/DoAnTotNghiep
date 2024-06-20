// ignore: duplicate_ignore
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/dark_mode_provider.dart';

import 'package:provider/provider.dart';

class CustomExpansionTile extends StatelessWidget {
  final List<Widget>? children;
  final bool? active;
  final Function(bool)? onchange;
  final String title;
  final IconData? leading;
  final Widget? trailing;
  const CustomExpansionTile({
    this.active,
    this.children,
    this.onchange,
    this.leading,
    required this.title,
    this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.read<DarkModeProvider>();
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: AppColors.transparent,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: provider.darkmode ? AppColors.gray : AppColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.tertiary,
              offset: Offset.fromDirection(1),
              blurRadius: 0.5,
            ),
          ],
        ),
        child: ExpansionTile(
          onExpansionChanged: onchange,
          iconColor: AppColors.tertiary,
          collapsedIconColor: AppColors.tertiary,
          title: Text(title,
              style: TextStyle(
                color: active ?? false
                    ? provider.darkmode
                        ? AppColors.greenLight
                        : AppColors.primary
                    : provider.darkmode
                        ? AppColors.white
                        : AppColors.textBlack,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
          leading: Icon(
            leading,
            color: active ?? false
                ? provider.darkmode
                    ? AppColors.greenLight
                    : AppColors.primary
                : provider.darkmode
                    ? AppColors.white
                    : AppColors.textBlack,
          ),
          children: children ?? [],
          trailing: trailing,
        ),
      ),
    );
  }
}
