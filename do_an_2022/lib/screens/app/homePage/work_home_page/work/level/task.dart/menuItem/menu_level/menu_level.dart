import 'package:demo_retrofit_api/models/level/level.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/work.dart';
import 'package:demo_retrofit_api/widget/popup_confirm/popup_confirm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../../../../theme/color.dart';
import '../../../../../../../../../widget/popup_level_name/popup_level_name.dart';

Widget MenuLevel(int id, BuildContext context) {
  late LevelModel levelModel;
  late WorkLogic workLogic;
  workLogic = context.read<WorkLogic>();
  for (int i = 0; i < workLogic.listLevel.length; i++) {
    if (workLogic.listLevel[i].id == id) {
      levelModel = workLogic.listLevel[i];
    }
  }
  final List<Tuple2<String, IconData>> contents = [
    Tuple2(
      "Sửa tên",
      Icons.create,
    ),
    Tuple2(
      "Xóa",
      Icons.delete,
    ),
  ];

  return PopupMenuButton(
    icon: Icon(Icons.more_horiz),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    itemBuilder: (context) {
      return contents
          .map(
            (e) => PopupMenuItem(
              value: e.item1,
              child: Row(
                children: [
                  Icon(
                    e.item2,
                    color: AppColors.textBlueBlack,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      e.item1,
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
          )
          .toList();
    },
    onSelected: ((value) {
      switch (value) {
        case "Sửa tên":
          PopupSetNameLevel(id, levelModel.name, context, () {});
          break;
        case "Xóa":
          PopupComfirm(context, "Bạn có muốn xóa mục này?", () {});
          break;
      }
    }),
  );
}
