import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/level/level.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../../../Config/Colors/colors.dart';
import '../../../../../../../../Widgets/ActionDialog/action_dialog.dart';
import '../../../../../../../../Widgets/popup_level_name/popup_level_name.dart';
import '../../../../work.dart';

Widget menuLevel(
    int id_level, int id_work, String lable, BuildContext context) {
  LevelLogic levelLogic = LevelLogic();

  final List<Tuple2<String, IconData>> contents = [
    const Tuple2(
      "Sửa tên",
      Icons.create,
    ),
    const Tuple2(
      "Xóa",
      Icons.delete,
    ),
  ];

  return PopupMenuButton(
    icon: const Icon(Icons.more_horiz),
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
                  const SizedBox(
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
          popupSetNameLevel(
            id_level,
            id_work,
            lable,
            context,
          );
          break;
        case "Xóa":
          actionDialog(context, "Bạn có muốn xóa mục này?",
              icon: Icons.question_mark_outlined, cancel: () {
            Navigator.pop(context);
          }, yes: () {
            levelLogic.deleteLevel(id_level);
            context.read<WorkLogic>().getListTask(id_work);
            Navigator.pop(context);
          });
          break;
      }
    }),
  );
}
