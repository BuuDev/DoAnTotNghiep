import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  final String? placeholder;
  final Widget? suFFixIcon;
  final Widget? preFixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? errorBorder;
  final bool? typePassword;
  final Function()? onTap;
  final bool? readOnly;
  final String? value;
  final double? height;
  final int? maxline;
  final double? paddingTop;
  final TextInputType? keyboardType;

  const TextFieldCustom({
    this.placeholder,
    this.preFixIcon,
    this.suFFixIcon,
    this.controller,
    this.onChanged,
    this.errorBorder,
    this.typePassword,
    this.onTap,
    this.readOnly,
    this.value,
    this.height,
    this.maxline,
    this.paddingTop,
    this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 60,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        maxLines: widget.maxline ?? 1,
        textInputAction: TextInputAction.next,
        onTap: widget.onTap,
        readOnly: widget.readOnly ?? false,
        initialValue:
            widget.controller != null ? widget.controller!.text : widget.value!,
        style: const TextStyle(
          color: AppColors.textBlack,
          fontSize: 14,
        ),
        obscureText: widget.typePassword ?? false,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          suffixIcon: widget.suFFixIcon,

          // InkWell(
          //     onTap: () {},
          //     child: const Icon(
          //       Icons.close,
          //       size: 20,
          //       color: AppColors.textTertiary,
          //     )),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     InkWell(
          //         onTap: () {},
          //         child: const Icon(
          //           Icons.close,
          //           size: 20,
          //           color: AppColors.textTertiary,
          //         )),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     InkWell(
          //         onTap: () {},
          //         child:
          //             const Icon(Icons.remove_red_eye_outlined)),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //   ],
          // ),

          hintText: widget.placeholder,
          hintStyle: const TextStyle(
            color: AppColors.textLightGray,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          contentPadding:
              EdgeInsets.only(left: 10, top: widget.paddingTop ?? 0),
          border: const OutlineInputBorder(
              gapPadding: 1,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.errorBorder ?? false
                    ? AppColors.red
                    : AppColors.tertiary,
                width: 2,
              ),
              gapPadding: 1,
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          focusedBorder: widget.errorBorder ?? false
              ? const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.red,
                    width: 2,
                  ),
                  gapPadding: 1,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))
              : null,
        ),
      ),
    );
  }
}
