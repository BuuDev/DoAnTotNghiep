import 'package:flutter/material.dart';

import '../../Config/Colors/colors.dart';

Future popupComfirm(BuildContext context, String title, Function() logic) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 18,
              color: AppColors.textBlueBlack,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.visible,
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
