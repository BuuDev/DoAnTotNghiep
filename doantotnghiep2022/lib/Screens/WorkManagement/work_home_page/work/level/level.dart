import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/level/task.dart/task_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Config/Colors/colors.dart';
import '../../../../../Models/workManage/task/task_model.dart';
import '../../../../../Services/Api/WordManage/work/work.dart';
import '../../../../../Services/Helper/notify_helper.dart';
import '../work.dart';
import 'task.dart/menuItem/menu_level/menu_level.dart';
import 'task.dart/task.dart';
part 'level_logic.dart';

class Level extends StatefulWidget {
  final TaskModelDemo taskItemModel;
  const Level({Key? key, required this.taskItemModel}) : super(key: key);

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  late LevelLogic levelLogic;

  static double width(BuildContext context) {
    double insets = MediaQuery.of(context).size.width;
    return insets;
  }

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    levelLogic = LevelLogic();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: levelLogic,
      child: Consumer<LevelLogic>(builder: (_, value, __) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: const BoxDecoration(
                color: AppColors.textLightGrayBG,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              width: width(context) * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom:
                            widget.taskItemModel.list_task.isEmpty ? 0 : 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.taskItemModel.name,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 18,
                                      color: AppColors.textBlueBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ),
                        menuLevel(
                            widget.taskItemModel.id,
                            widget.taskItemModel.work_id,
                            widget.taskItemModel.name,
                            context)
                      ],
                    ),
                  ),
                  widget.taskItemModel.list_task == []
                      ? const SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.taskItemModel.list_task.length,
                          itemBuilder: (BuildContext context, int index) =>
                              TaskItemWidget(
                                id_work: widget.taskItemModel.work_id,
                                nameLevel: widget.taskItemModel.name,
                                taskItemModel:
                                    widget.taskItemModel.list_task[index],
                              )),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => Task(
                                    model: null,
                                    level_id: widget.taskItemModel.id,
                                    work_id: widget.taskItemModel.work_id,
                                    nameLevel: widget.taskItemModel.name,
                                    checkCreateOrEdit: false,
                                  ),
                                ));
                          });
                        },
                        child: Text(
                          "+ Thêm",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textTertiary,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
