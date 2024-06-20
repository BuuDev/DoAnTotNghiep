import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Config/Colors/colors.dart';
import '../../work_manage.dart';

Widget searchWord(BuildContext context) {
  return Consumer<WorkManagementLogic>(builder: (_, value, __) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: value.controllerSearch,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: AppColors.black,
                  ),
              onChanged: (text) {
                text = text.toLowerCase();
                value.setLstHienThi(text);
              },
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundColor,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textLightGray,
                ),
                hintText: "Tìm kiếm",
                hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: AppColors.textLightGray,
                    ),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(36),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(36),
                ),
              ),
            ),
          ),
        ),
        if (value.controllerSearch.text != '')
          TextButton(
            onPressed: () {
              value.returnSearch();
            },
            child: Text(
              "Hủy",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
      ],
    );
  });
}
