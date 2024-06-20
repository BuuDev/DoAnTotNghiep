import 'package:doantotnghiep/Models/workManage/level/level_demo.dart';
import 'package:doantotnghiep/Models/workManage/level/level_item_demo.dart';
import 'package:doantotnghiep/Models/workManage/task/task_item_model.dart';
import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/level/task.dart/task.dart';
import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/work.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../../../Config/Colors/colors.dart';
import '../../../../../../../../Widgets/ActionDialog/action_dialog.dart';
import '../../../../../../../Account/account.dart';
import '../../popup_addUserTask/popup_addUserTask.dart';

Widget menuTitle(BuildContext context, TaskItemModel taskItemModel,
    LevelDemo levelDemo, int id_level, int id_work, id_user) {
  TaskLogic taskLogic = TaskLogic(context: context);
  final List<Tuple2<String, IconData>> contents = [
    const Tuple2(
      "Thêm thành viên",
      Icons.person_add,
    ),
    const Tuple2(
      "Chuyển mục",
      Icons.navigate_next,
    ),
    const Tuple2(
      "Xóa",
      Icons.delete,
    ),
  ];
  return ChangeNotifierProvider.value(
    value: taskLogic,
    child: Consumer<TaskLogic>(builder: (_, logic, __) {
      return PopupMenuButton(
        icon: const Icon(
          Icons.more_horiz,
          color: AppColors.textBlueBlack,
        ),
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
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
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
            case "Thêm thành viên":
              showPopupAddTask(context, taskItemModel.id);
              break;
            case "Chuyển mục":
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  backgroundColor: AppColors.lightGray,
                  title: Text(
                    "Chuyển mục",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 22,
                          color: AppColors.textBlueBlack,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(levelDemo.level!.length, (index) {
                        return InkWell(
                          onTap: (() {
                            if (levelDemo.level![index].id !=
                                taskItemModel.level_id) {
                              actionDialog(
                                  context, "Bạn có muốn chuyển nhiệm vụ này?",
                                  icon: Icons.question_mark_outlined,
                                  cancel: () {
                                Navigator.pop(context);
                              }, yes: () async {
                                await logic.deleteTask(taskItemModel.id);
                                await logic.createTask(
                                    levelDemo.level![index].id,
                                    taskItemModel.title!,
                                    taskItemModel.content ?? "",
                                    taskItemModel.timeStart ?? "",
                                    taskItemModel.timeOut ?? "");
                                context.read<WorkLogic>().getListTask(id_work);
                                Navigator.pop(context);
                              }).then((value) => Navigator.pop(context));
                            }
                          }),
                          child: Card(
                            color: levelDemo.level![index].id ==
                                    taskItemModel.level_id
                                ? AppColors.gray
                                : AppColors.primary,
                            child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  levelDemo.level![index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontSize: 16,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
              );
              break;
            case "Xóa":
              if (context.read<AccountLogic>().user!.id == id_user) {
                actionDialog(context, "Bạn có muốn xóa nhiệm vụ này?",
                    icon: Icons.question_mark_outlined,
                    cancel: () {}, yes: () async {
                  await context.read<TaskLogic>().deleteTask(taskItemModel.id);
                  context.read<WorkLogic>().getListTask(id_work);
                  Navigator.pop(context);
                }).then((value) => Navigator.pop(context));
              }

              break;
          }
        }),
      );
    }),
  );
}
