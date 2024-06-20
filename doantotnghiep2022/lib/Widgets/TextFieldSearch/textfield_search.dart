import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:flutter/material.dart';

class TextFieldSearch extends StatelessWidget {
  final String? placeholder;
  final Function(String)? onChanged;
  final bool? readOnly;
  final Function()? onTap;
  final Widget? suffixIcon;
  const TextFieldSearch({
    this.placeholder,
    this.onChanged,
    this.readOnly,
    this.onTap,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: '$placeholder...',
        hintStyle: const TextStyle(
          color: AppColors.tertiary,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.tertiary,
        ),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.only(left: 10),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          borderSide: BorderSide(
            color: AppColors.tertiary,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          borderSide: BorderSide(
            color: AppColors.tertiary,
          ),
        ),
      ),
    );
  }
}
