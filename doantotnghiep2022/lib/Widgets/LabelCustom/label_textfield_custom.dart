import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:flutter/material.dart';

class LabelTextFieldCustom extends StatelessWidget {
  final String value;
  final bool? required;
  const LabelTextFieldCustom({
    required this.value,
    this.required,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
            text: '$value ',
            style: const TextStyle(
                color: AppColors.textBlack,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat')),
        TextSpan(
            text: required ?? true ? '*' : '',
            style: const TextStyle(
              color: AppColors.red,
            )),
      ],
    ));
  }
}
