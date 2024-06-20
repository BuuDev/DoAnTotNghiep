import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/work.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Config/Colors/colors.dart';
import '../../Screens/WorkManagement/work_home_page/work/level/level.dart';

Future popupSetNameLevel(
  int? id,
  int? id_work,
  String? lable,
  BuildContext context,
) {
  TextEditingController controller = TextEditingController(text: lable);
  late LevelLogic levelLogic;
  levelLogic = LevelLogic();
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: TextField(
        autofocus: true,
        maxLength: 30,
        maxLines: 2,
        controller: controller,
        style: const TextStyle(
          color: AppColors.textBlueBlack,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.clip,
        ),
        decoration: InputDecoration(
          hintText: id == null ? "Đặt Tên Mục ..." : null,
          hintStyle: const TextStyle(
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
          onPressed: () async {
            if (id == null) {
              await levelLogic.createLevel(id_work!, controller.text);
              context.read<WorkLogic>().getListTask(id_work);
              Navigator.pop(context);
            } else {
              await levelLogic.editLevel(id, controller.text);
              Navigator.pop(context);
              context.read<WorkLogic>().getListTask(id_work!);
            }
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
