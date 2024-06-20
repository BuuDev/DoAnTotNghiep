import 'package:flutter/material.dart';

import '../../theme/color.dart';

Future PopupSetNameLevel(
    int? id, String? lable, BuildContext context, void Function()? logic) {
  TextEditingController controller = TextEditingController(text: lable);

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: TextField(
        autofocus: true,
        maxLength: 30,
        maxLines: 2,
        controller: controller,
        style: TextStyle(
          color: AppColors.textBlueBlack,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.clip,
        ),
        decoration: InputDecoration(
          hintText: id == null ? "Đặt Tên Mục ..." : null,
          hintStyle: TextStyle(
            color: AppColors.gray,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.clip,
          ),
          filled: true,
          fillColor: AppColors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            logic;
          },
          child: Text(
            "Đồng ý",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 16,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(
            "Đóng",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 16,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    ),
  );
}
