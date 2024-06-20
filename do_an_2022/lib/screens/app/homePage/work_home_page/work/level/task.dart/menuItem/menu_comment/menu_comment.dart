import 'package:flutter/material.dart';

import '../../../../../../../../../theme/color.dart';

Widget MenuComment() {
  return PopupMenuButton(
    icon: Icon(
      Icons.settings,
      color: AppColors.textBlueBlack,
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    itemBuilder: (context) => [
      PopupMenuItem(
        child: Row(
          children: [
            Icon(
              Icons.emoji_people,
              color: AppColors.textBlueBlack,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                "Thêm thành viên",
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
            Icon(
              Icons.delete,
              color: AppColors.textBlueBlack,
            ),
            SizedBox(
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
