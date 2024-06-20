import 'dart:io';

import 'package:demo_retrofit_api/models/task/task_attachments/task_attchaments.dart';
import 'package:demo_retrofit_api/models/task/task_details/task_details.dart';
import 'package:demo_retrofit_api/models/task/task_images/task_images.dart';
import 'package:demo_retrofit_api/models/task/task_model.dart';
import 'package:demo_retrofit_api/models/task/task_sub/task_sub.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/level/task.dart/popup/dialog_mota.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/work.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'commentItem/comment.dart';
import 'menuItem/menu_comment/menu_comment.dart';
import 'menuItem/menu_title/menu_title.dart';
import 'tienich/tienich.dart';
import 'watch_image/watch_image.dart';
part 'task_logic.dart';

class Task extends StatefulWidget {
  final int? id;
  Task({Key? key, required this.id}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late TaskLogic taskLogic;
  late WorkLogic workLogic;
  late TaskModel taskModel;
  //late PageController controller;

  Widget Imagepicker(int index, List<XFile> lstimage, TaskLogic logic) {
    return InkWell(
      onTap: (() {
        setState(() {
          //logic.updateImage(index);
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => WatchImage(
                file: lstimage,
                color: logic.color,
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
            Material(
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.file(
                File(lstimage[index].path),
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
                      child: Icon(
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

  @override
  void initState() {
    taskLogic = context.read<TaskLogic>();
    workLogic = context.read<WorkLogic>();
    for (int i = 0; i < workLogic.listTask.length; i++) {
      if (workLogic.listTask[i].id == widget.id) {
        taskModel = workLogic.listTask[i];
      }
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
              leading: InkWell(
                  onTap: (() {
                    Navigator.pop(context);
                  }),
                  child: Icon(
                    Icons.close,
                    color: AppColors.white,
                  )),
              actions: [
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: MenuTitle()),
              ],
              backgroundColor: logic.color,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    color: AppColors.white,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: logic.controllerTitle,
                          onChanged: (text) {},
                          maxLines: null,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: AppColors.textBlueBlack, fontSize: 22),
                          decoration: InputDecoration(
                            hintText: widget.id != null
                                ? taskModel.title
                                : "Đặt tên Task",
                            border: InputBorder.none,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: AppColors.textBlueBlack,
                                    fontSize: 22),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: AppColors.textBlueBlack,
                                    fontSize: 22),
                          ),
                        ),
                        Text(
                          "Trong mục: ",
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
                  TienIch(),
                  Selector<TaskLogic, List<XFile>>(
                    selector: ((_, state) => state.images),
                    builder: (_, lstimage, __) {
                      return lstimage == []
                          ? SizedBox()
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
                                                    Imagepicker(
                                                        index, lstimage, logic),
                                                    Center(
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
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .white,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Imagepicker(
                                                index, lstimage, logic),
                                          );
                                        },
                                      )
                                    : List.generate(
                                        lstimage.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Imagepicker(
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
                      PopupMota(context);
                    },
                    child: Container(
                      color: AppColors.white,
                      height: 100,
                      child: ListTile(
                        leading: Icon(
                          Icons.subject,
                          color: AppColors.black,
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
                  const SizedBox(
                    width: double.infinity,
                    height: 15,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Divider(
                        height: 2,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        taskLogic.chandgeDate(context);
                      });
                    },
                    child: Selector<TaskLogic, DateTime>(
                        selector: (_, state) => state._currentdate,
                        builder: (_, value, __) {
                          return Container(
                            color: AppColors.white,
                            child: ListTile(
                              leading: Icon(
                                Icons.access_time,
                                color: AppColors.black,
                                size: 28,
                              ),
                              title: Text(
                                value == DateTime(0, 0, 0)
                                    ? "Ngày hết hạn"
                                    : "Hết hạn vào ${value.day} tháng ${value.month}",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 18,
                                      color: value == DateTime(0, 0, 0)
                                          ? AppColors.gray
                                          : AppColors.textBlueBlack,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              trailing: Checkbox(
                                activeColor: value == DateTime(0, 0, 0)
                                    ? AppColors.gray
                                    : AppColors.primary,
                                value: value == DateTime(0, 0, 0)
                                    ? true
                                    : logic.checkTask,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != DateTime(0, 0, 0)) {
                                      logic.checkTask = value!;
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 15,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Divider(
                        height: 2,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.person_outline,
                        color: AppColors.black,
                        size: 28,
                      ),
                      title: Text(
                        "Thành Viên...",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 18,
                              color: AppColors.gray,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
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
                          primary: logic.color,
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
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
                        MenuComment()
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return itemCommment(index.toString(), context);
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
