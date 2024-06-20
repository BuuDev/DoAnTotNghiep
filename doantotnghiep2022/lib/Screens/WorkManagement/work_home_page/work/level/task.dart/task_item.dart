import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../Config/Colors/colors.dart';
import '../../../../../../Models/UserSkinDetective/user_demo.dart';
import '../../../../../../Models/workManage/task/task_item_model.dart';
import '../../../../../../gen/assets.gen.dart';
import 'task.dart';

class TaskItemWidget extends StatefulWidget {
  final int id_work;
  final String nameLevel;
  final TaskItemModel taskItemModel;
  const TaskItemWidget(
      {Key? key,
      required this.id_work,
      required this.nameLevel,
      required this.taskItemModel})
      : super(key: key);

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  late TaskLogic taskLogic;
  List<UserDemo> lst = [];
  @override
  void initState() {
    super.initState();
    taskLogic = TaskLogic(context: context);
    taskLogic.getlstAssignUser(widget.taskItemModel.assign!);
    taskLogic.readData(widget.taskItemModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: taskLogic,
      child: Consumer<TaskLogic>(builder: (_, logic, __) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => Task(
                  model: widget.taskItemModel,
                  level_id: widget.taskItemModel.id,
                  work_id: widget.id_work,
                  nameLevel: widget.nameLevel,
                  checkCreateOrEdit: true,
                ),
              ),
            ).then((value) {
              taskLogic.getlstAssignUser(widget.taskItemModel.assign!);
              taskLogic.readData(widget.taskItemModel.id);
            });
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          widget.taskItemModel.title!,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 15,
                                    color: AppColors.textBlueBlack,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            if (widget.taskItemModel.timeOut != null)
                              SizedBox(
                                height: 30,
                                child: Card(
                                  color: AppColors.red,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.access_time,
                                        color: AppColors.white,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Center(
                                          child: Text(
                                        "${DateFormat('yyyy-MM-dd').parse(widget.taskItemModel.timeOut!).day} tháng ${DateFormat('yyyy-MM-dd').parse(widget.taskItemModel.timeOut!).month}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                              fontSize: 13,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (logic.lstTaskDetail.isNotEmpty)
                              Container(
                                height: 30,
                                child: Card(
                                  color: logic.counterStatus() == 0
                                      ? AppColors.red
                                      : (logic.counterStatus() ==
                                              logic.lstTaskDetail.length)
                                          ? AppColors.green
                                          : AppColors.yellow,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.check_box_outlined,
                                        color: AppColors.white,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Center(
                                          child: Text(
                                        "${logic.counterStatus()}/${logic.lstTaskDetail.length}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                              fontSize: 13,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Selector<TaskLogic, List<UserDemo>>(
                                selector: (_, state) => state.lstAssign,
                                builder: (_, lst, __) {
                                  return Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: List.generate(
                                              lst.length > 3 ? 3 : lst.length,
                                              (index) {
                                            if (lst.length > 3 && index == 2) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Stack(
                                                  children: [
                                                    Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              36),
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      child: Image.network(
                                                          lst[index].avatar ??
                                                              "",
                                                          width: 35,
                                                          height: 35,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (_, __, ___) {
                                                        return Image.asset(
                                                          Assets.images
                                                              .avatarNull.path,
                                                          width: 35,
                                                          height: 35,
                                                        );
                                                      }),
                                                    ),
                                                    Opacity(
                                                      opacity: 0.6,
                                                      child: SizedBox(
                                                        width: 35,
                                                        height: 35,
                                                        child: Material(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        36),
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: Center(
                                                              child: Text(
                                                                  "+ ${lst.length - index}"),
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(36),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: Image.network(
                                                    lst[index].avatar ?? "",
                                                    width: 35,
                                                    height: 35,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (_, __, ___) {
                                                  return Image.asset(
                                                    Assets
                                                        .images.avatarNull.path,
                                                    width: 35,
                                                    height: 35,
                                                  );
                                                }),
                                              ),
                                            );
                                          }),
                                        )),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
