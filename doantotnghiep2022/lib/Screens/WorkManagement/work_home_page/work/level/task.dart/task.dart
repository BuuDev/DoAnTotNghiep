import 'dart:convert';
import 'dart:io';

import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:doantotnghiep/Models/workManage/level/level_demo.dart';
import 'package:doantotnghiep/Models/workManage/level/level_item_demo.dart';
import 'package:doantotnghiep/Models/workManage/task/task_priority/task_priority.dart';
import 'package:doantotnghiep/Models/workManage/userwork/user_work.dart';
import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/work.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import '../../../../../../Config/Colors/colors.dart';
import '../../../../../../Models/workManage/task/task_assign/task_assign.dart';
import '../../../../../../Models/workManage/task/task_item_model.dart';
import '../../../../../../Services/Api/WordManage/task/task.dart';
import '../../../../../../Services/Api/WordManage/work/work.dart';
import '../../../../../../Services/Api/demoCallApi/demo.dart';
import '../../../../../../Services/Helper/notify_helper.dart';
import '../../../../../../Widgets/ActionDialog/action_dialog.dart';
import '../../../../../../Widgets/datetime_input/datetime_input.dart';
import '../../../../../../gen/assets.gen.dart';
import 'commentItem/comment.dart';
import 'menuItem/menu_task/menu_task.dart';
import 'popup/dialog_mota.dart';
import 'tienich/tienich.dart';
import 'watch_image/watch_image.dart';
part 'task_logic.dart';

class Task extends StatefulWidget {
  final TaskItemModel? model;
  final int level_id;
  final int work_id;
  final String? nameLevel;
  final bool checkCreateOrEdit;
  const Task(
      {Key? key,
      required this.model,
      required this.level_id,
      required this.work_id,
      required this.nameLevel,
      required this.checkCreateOrEdit})
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late TaskLogic taskLogic;
  late TaskItemModel taskModel = TaskItemModel(
      id: 0,
      title: "",
      content: "",
      index: 0,
      type: "",
      timeOut: null,
      status: 0,
      assign: [],
      attchaments: [],
      comment: [],
      completeAt: "",
      level_id: 0,
      priority_id: 0,
      priority: null,
      timeStart: null,
      user_id: 0,
      createdAt: "",
      updatedAt: "",
      deletedAt: "");

  late FileType fileType;

  Widget imagePicker(int index, List<XFile> lstimage, TaskLogic logic) {
    return InkWell(
      onTap: (() {
        setState(() {
          //logic.updateImage(index);
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => WatchImage(
                file: lstimage,
                menuItem: true,
                index: index,
              ),
            ),
          );
        });
      }),
      child: SizedBox(
        height: 150,
        width: 110,
        child: Stack(
          children: [
            Center(
              child: Material(
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.file(
                  File(lstimage[index].path),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        logic.removeImage(index);
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.remove_circle_outline,
                        color: AppColors.textBlueBlack,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget filePicker(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return InkWell(
      onTap: () {
        OpenFile.open(file.path);
        //OpenFile.open(file.path, linuxByProcess: true);
      },
      child: ListTile(
        leading: (file.extension == 'jpg' || file.extension == 'png')
            ? Image.file(
                File(file.path.toString()),
                width: 80,
                height: 80,
              )
            : const Icon(
                Icons.file_open,
                color: AppColors.primary,
                size: 50,
              ),
        title: Text(
          file.name,
          overflow: TextOverflow.visible,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: AppColors.textBlueBlack, fontSize: 14),
        ),
        subtitle: Text(
          '${file.extension}',
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: AppColors.textBlueBlack, fontSize: 14),
        ),
        trailing: Text(
          size,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: AppColors.textBlueBlack, fontSize: 14),
        ),
      ),
    );
  }

  @override
  void initState() {
    taskLogic = TaskLogic(context: context);
    if (widget.checkCreateOrEdit) {
      taskModel = widget.model!;
      taskLogic.getlstAssignUser(widget.model!.assign!);
      taskLogic.getLstLevel(widget.work_id);
      taskLogic.controllerTitle.text = widget.model!.title!;
      taskLogic.readData(widget.model!.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: taskLogic,
      child: Consumer<TaskLogic>(builder: (_, logic, __) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: AppColors.lightGray,
            appBar: AppBar(
                backgroundColor: AppColors.white,
                title: Text(widget.checkCreateOrEdit ? "" : "Thêm Nhiệm Vụ",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: AppColors.textBlueBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 22)),
                leading: InkWell(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textBlueBlack,
                    )),
                actions: [
                  if (widget.checkCreateOrEdit)
                    Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: menuTitle(
                            context,
                            widget.model!,
                            logic.lstLevel,
                            widget.model!.level_id,
                            widget.work_id,
                            widget.model!.user_id)),
                ]),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    color: AppColors.white,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: logic.controllerTitle,
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            setState(() {
                              taskModel.title = text;
                            });
                          },
                          maxLines: null,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: AppColors.textBlueBlack,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22),
                          decoration: InputDecoration(
                            hintText: "Đặt tên Task",
                            border: InputBorder.none,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: AppColors.textBlueBlack,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: AppColors.gray,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22),
                          ),
                        ),
                        Text(
                          "Trong mục: ${widget.nameLevel}",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 18,
                                    color: AppColors.gray,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: Divider(
                      height: 1,
                      color: AppColors.gray,
                    ),
                  ),
                  if (widget.checkCreateOrEdit) const TienIch(),
                  if (widget.checkCreateOrEdit)
                    Selector<TaskLogic, List<PlatformFile>>(
                        selector: (_, state) => state.lstFile,
                        builder: (_, lst, __) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lst.length,
                              itemBuilder: (context, index) {
                                final file = lst[index];
                                return filePicker(file);
                              });
                        }),
                  if (widget.checkCreateOrEdit)
                    Selector<TaskLogic, List<XFile>>(
                      selector: ((_, state) => state.images),
                      builder: (_, lstimage, __) {
                        return lstimage == []
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: lstimage.length >= 3
                                      ? List.generate(
                                          3,
                                          (index) {
                                            if (index == 2) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  height: 150,
                                                  width: 110,
                                                  child: Stack(
                                                    children: [
                                                      imagePicker(index,
                                                          lstimage, logic),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute<
                                                                void>(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  WatchImage(
                                                                file: lstimage,
                                                                menuItem: true,
                                                                index: 0,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Center(
                                                          child: Opacity(
                                                            opacity: 0.6,
                                                            child: Container(
                                                              height: 150,
                                                              width: 110,
                                                              child: Center(
                                                                child: Text(
                                                                  (lstimage.length -
                                                                              2)
                                                                          .toString() +
                                                                      "+",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle1!
                                                                      .copyWith(
                                                                        color: AppColors
                                                                            .textBlueBlack,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                              ),
                                                              decoration: const BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12))),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: imagePicker(
                                                  index, lstimage, logic),
                                            );
                                          },
                                        )
                                      : List.generate(
                                          lstimage.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: imagePicker(
                                                index, lstimage, logic),
                                          ),
                                        ),
                                ),
                              );
                      },
                    ),
                  const SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Divider(
                        height: 2,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      popupMota(context).then((value) {
                        taskModel.content = logic.controllerMoTa.text;
                      });
                    },
                    child: Container(
                      color: AppColors.white,
                      height: 100,
                      child: ListTile(
                        leading: const Icon(
                          Icons.subject,
                          color: AppColors.primary,
                          size: 28,
                        ),
                        title: Text(
                          logic.lableMota.isEmpty
                              ? "Chạm để thêm mô tả"
                              : logic.lableMota,
                          maxLines: 4,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 18,
                                  color:
                                      logic.lableMota == "Chạm để thêm mô tả" ||
                                              logic.lableMota.isEmpty
                                          ? AppColors.gray
                                          : AppColors.textBlueBlack,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ngày bắt đầu",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 18,
                              color: AppColors.textBlueBlack,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                  DateTimeInput(
                    date: taskModel.timeStart,
                    checkDateTaskorWork: true,
                    onCheck: (value) {
                      setState(() {
                        taskModel.timeStart = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ngày hết hạn",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 18,
                              color: AppColors.textBlueBlack,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                  DateTimeInput(
                    date: taskModel.timeOut,
                    checkDateTaskorWork: true,
                    onCheck: (value) {
                      setState(() {
                        taskModel.timeOut = value;
                      });
                    },
                  ),
                  if (widget.checkCreateOrEdit)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Icon(Icons.people_outline),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Danh sách thành viên",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontSize: 18,
                                    color: AppColors.textBlueBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (widget.checkCreateOrEdit)
                    Selector<TaskLogic, List<UserDemo>?>(
                        selector: (_, state) => state.lstAssign,
                        builder: (_, lst, __) {
                          return InkWell(
                            onTap: (() {
                              User(context, lst!);
                            }),
                            child: Container(
                              color: AppColors.white,
                              child: ListTile(
                                leading: const Icon(
                                  Icons.person_outline,
                                  color: AppColors.primary,
                                  size: 28,
                                ),
                                title: SizedBox(
                                  width: double.infinity,
                                  child: lst!.isNotEmpty
                                      ? Stack(
                                          children: List.generate(
                                              lst.length > 4 ? 4 : lst.length,
                                              (index) {
                                            return (index == 3 &&
                                                    lst.length > 4)
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: (((lst.length > 4
                                                                        ? 4
                                                                        : lst
                                                                            .length) -
                                                                    ((lst.length >
                                                                                4
                                                                            ? 4
                                                                            : lst.length) -
                                                                        index)) *
                                                                22)
                                                            .toDouble()),
                                                    child: Stack(
                                                      children: [
                                                        Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(36),
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          child: Image.network(
                                                              lst[index]
                                                                      .avatar ??
                                                                  "",
                                                              width: 35,
                                                              height: 35,
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (_, __, ___) {
                                                            return Image.asset(
                                                              Assets
                                                                  .images
                                                                  .avatarNull
                                                                  .path,
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
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: (((lst.length > 4
                                                                        ? 4
                                                                        : lst
                                                                            .length) -
                                                                    ((lst.length >
                                                                                4
                                                                            ? 4
                                                                            : lst.length) -
                                                                        index)) *
                                                                22)
                                                            .toDouble()),
                                                    child: Material(
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
                                                  );
                                          }),
                                        )
                                      : const SizedBox(),
                                ),
                                trailing: const Icon(Icons.arrow_drop_down),
                              ),
                            ),
                          );
                        }),
                  Selector<TaskLogic,
                          Tuple3<bool, FocusNode, List<TaskPriority>>>(
                      selector: ((_, state) => Tuple3(state.hideLstTaskDetail,
                          state.focusNode, state.lstTaskDetail)),
                      builder: (_, checkTaskDetail, __) {
                        return Visibility(
                          visible: checkTaskDetail.item1 ||
                              checkTaskDetail.item3.isNotEmpty,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, right: 15, left: 15),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Assets.icons.checklistIcon,
                                        width: 28, height: 28),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Text("Danh sách công việc",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  fontSize: 18,
                                                  color:
                                                      AppColors.textBlueBlack,
                                                  fontWeight: FontWeight.w500,
                                                ))),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: checkTaskDetail.item3.length + 1,
                                itemBuilder: ((context, index) {
                                  if (index == checkTaskDetail.item3.length) {
                                    return Selector<TaskLogic,
                                            TextEditingController>(
                                        selector: ((_, state) =>
                                            state.controllerWork),
                                        builder: (_, controller, __) {
                                          return Container(
                                            color: AppColors.white,
                                            child: ListTile(
                                              trailing: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (controller
                                                        .text.isNotEmpty) {
                                                      logic.addItem(
                                                          controller.text,
                                                          widget.model!.id);
                                                      controller.text = "";
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.check,
                                                  color: controller.text.isEmpty
                                                      ? AppColors.gray
                                                      : AppColors.primary,
                                                ),
                                              ),
                                              title: TextFormField(
                                                focusNode:
                                                    checkTaskDetail.item2,
                                                controller: controller,
                                                onChanged: (text) {},
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                      fontSize: 13,
                                                      color: AppColors
                                                          .textBlueBlack,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      AppColors.backgroundColor,
                                                  enabled: true,
                                                  border: InputBorder.none,
                                                  hintText: "Thêm Công Việc...",
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                        fontSize: 13,
                                                        color: AppColors.gray,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                  return Slidable(
                                    endActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        children: <Widget>[
                                          SlidableAction(
                                            backgroundColor: AppColors.red,
                                            label: "Xóa",
                                            onPressed: (e) {
                                              logic.deleteItem(
                                                  checkTaskDetail
                                                      .item3[index].id,
                                                  widget.model!.id);
                                            },
                                            icon: Icons.delete,
                                          )
                                        ]),
                                    child: Container(
                                      color: AppColors.white,
                                      child: ListTile(
                                        leading: Checkbox(
                                          value: checkTaskDetail
                                                  .item3[index].status ==
                                              1,
                                          onChanged: (value) {
                                            setState(() {
                                              if (checkTaskDetail
                                                      .item3[index].status ==
                                                  0) {
                                                checkTaskDetail
                                                    .item3[index].status = 1;
                                              } else {
                                                checkTaskDetail
                                                    .item3[index].status = 0;
                                              }
                                              logic.writeData(
                                                  logic.lstTaskDetail,
                                                  widget.level_id);
                                            });
                                          },
                                        ),
                                        title: Text(
                                            checkTaskDetail.item3[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  fontSize: 15,
                                                  color:
                                                      AppColors.textBlueBlack,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        );
                      }),
                  if (taskModel.title!.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Tên dự án không được trống!",
                            style: TextStyle(
                                color: AppColors.red,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  if (taskModel.timeOut != "" &&
                      taskModel.timeStart != "" &&
                      DateFormat('yyyy-MM-dd hh:mm:ss')
                              .parse(taskModel.timeOut ?? "0-0-0 0:0:0")
                              .difference(DateFormat('yyyy-MM-dd hh:mm:ss')
                                  .parse(taskModel.timeStart ?? "0-0-0 0:0:0"))
                              .inDays <
                          0)
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Ngày kết thúc không được ở trước ngày bắt đầu!",
                            style: TextStyle(
                                color: AppColors.red,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Center(
                        child: SizedBox(
                      height: 55,
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: (taskModel.title!.isNotEmpty &&
                                  DateFormat('yyyy-MM-dd hh:mm:ss')
                                          .parse(taskModel.timeOut ??
                                              "0-0-0 0:0:0")
                                          .difference(
                                              DateFormat('yyyy-MM-dd hh:mm:ss')
                                                  .parse(taskModel.timeStart ??
                                                      "0-0-0 0:0:0"))
                                          .inDays >=
                                      0)
                              ? AppColors.primary
                              : AppColors.gray,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                        ),
                        child: Text("Lưu",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 18,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                    )),
                        onPressed: () async {
                          if (taskModel.title!.isNotEmpty) {
                            if (widget.checkCreateOrEdit) {
                              await logic.editTask(
                                  taskModel.id,
                                  taskModel.title!,
                                  taskModel.content ?? "",
                                  taskModel.timeStart ?? "",
                                  taskModel.timeOut ?? "");
                              context
                                  .read<WorkLogic>()
                                  .getListTask(widget.work_id);
                            } else {
                              await logic.createTask(
                                  widget.level_id,
                                  taskModel.title!,
                                  taskModel.content ?? "",
                                  taskModel.timeStart ?? "",
                                  taskModel.timeOut ?? "");
                              context
                                  .read<WorkLogic>()
                                  .getListTask(widget.work_id);
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    )),
                  ),
                  if (widget.checkCreateOrEdit)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Text(
                          "Hoạt động",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 18,
                                    color: AppColors.textBlueBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ),
                  if (widget.checkCreateOrEdit)
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Selector<TaskLogic, TextEditingController>(
                          selector: (_, status) => status.controllerComment,
                          builder: (_, controller, __) {
                            return Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                      controller: controller,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            color: AppColors.black,
                                          ),
                                      onChanged: (text) {
                                        setState(() {
                                          controller =
                                              TextEditingController(text: text);
                                        });
                                      },
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.backgroundColor,
                                        hintText: "Thêm Bình Luận",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                              color: AppColors.textLightGray,
                                            ),
                                        border: const OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(36),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: AppColors.primary,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(36),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (controller.text != '')
                                  TextButton(
                                    onPressed: () {
                                      logic.createComment(
                                          widget.model!.id, controller.text);
                                      context
                                          .read<WorkLogic>()
                                          .getListTask(widget.work_id);
                                    },
                                    child: Text(
                                      "Thêm",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            color: AppColors.textTertiary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                              ],
                            );
                          }),
                    ),
                  if (widget.checkCreateOrEdit && taskModel.comment!.isNotEmpty)
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: taskModel.comment!.length,
                        itemBuilder: (context, index) {
                          return itemCommment(
                              taskModel.comment![index], context);
                        }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

Future<void> popupUser(BuildContext context, List<UserDemo> lst) {
  TaskLogic taskLogic = TaskLogic(context: context);
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.lightGray,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "Các Thành Viên",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 18,
                        color: AppColors.textBlueBlack,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              InkWell(
                  onTap: (() {
                    Navigator.pop(context);
                  }),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.textBlueBlack,
                  )),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: ListView.builder(
                    itemCount: lst.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: ListTile(
                          leading: Material(
                            borderRadius: BorderRadius.circular(45),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network(lst[index].avatar ?? "",
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover, errorBuilder: (_, __, ___) {
                              return Image.asset(
                                Assets.images.avatarNull.path,
                                width: 45,
                                height: 45,
                              );
                            }),
                          ),
                          title: Text(
                            lst[index].fullname!,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 13,
                                      color: AppColors.textBlueBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          trailing: InkWell(
                              onTap: () async {
                                int id = 0;
                                for (int i = 0;
                                    i <
                                        context
                                            .read<WorkLogic>()
                                            .lstSearchUser!
                                            .length;
                                    i++) {
                                  if (lst[index].id ==
                                      context
                                          .read<WorkLogic>()
                                          .lstSearchUser![i]
                                          .id) {
                                    id = context
                                        .read<WorkLogic>()
                                        .lstSearchUser![i]
                                        .pivot
                                        .id;
                                  }
                                }
                                actionDialog(
                                    context, "Bạn có muốn xóa thành viên này?",
                                    icon: Icons.question_mark_outlined,
                                    cancel: () {
                                  Navigator.pop(context);
                                }, yes: () {
                                  taskLogic.deleteUserTask(id);

                                  Navigator.pop(context);
                                });
                              },
                              child: const Icon(
                                Icons.delete,
                                color: AppColors.textBlueBlack,
                              )),
                        ),
                      );
                    })),
              ),
            ],
          ),
        );
      });
}
