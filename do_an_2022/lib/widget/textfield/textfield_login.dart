import 'package:flutter/material.dart';

import '../../theme/color.dart';

class TextFiledLogin extends StatelessWidget {
  const TextFiledLogin({
    Key? key,
    required this.context,
    required this.Subtext,
    required this.hintText,
    this.obscure,
    required this.color,
    this.controller,
    this.onChanged,
  }) : super(key: key);
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final BuildContext context;
  final bool? obscure;
  final String Subtext;
  final String hintText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              Subtext,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: color),
            ),
          ),
          TextFormField(
            controller: controller,
            onChanged: onChanged,
            obscureText: obscure == null ? false : obscure!,
            style: const TextStyle(color: AppColors.gray),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                  color: AppColors.gray,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
