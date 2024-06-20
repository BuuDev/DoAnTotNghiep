import 'package:flutter/material.dart';

import '../../../../../../../../Config/Colors/colors.dart';

Widget menuComment() {
  return PopupMenuButton(
    icon: const Icon(
      Icons.more_horiz,
      color: AppColors.textBlueBlack,
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    itemBuilder: (context) => [
      PopupMenuItem(
        child: Row(
          children: [
            const Icon(
              Icons.edit,
              color: AppColors.textBlueBlack,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                "Sửa Bình Luận",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 18,
                      color: AppColors.textBlueBlack,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        child: Row(
          children: [
            const Icon(
              Icons.delete,
              color: AppColors.textBlueBlack,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                "Xóa",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 18,
                      color: AppColors.textBlueBlack,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
