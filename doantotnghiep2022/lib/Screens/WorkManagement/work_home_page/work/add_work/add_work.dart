import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/add_work/popup_addUser_work.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../Config/Colors/colors.dart';
import '../../../../../Models/UserSkinDetective/user_demo.dart';
import '../../../../../Models/workManage/work/work.dart';
import '../../../../../Services/Api/WordManage/work/work.dart';
import '../../../../../Services/Api/demoCallApi/demo.dart';
import '../../../../../Services/Helper/notify_helper.dart';
import '../../../../../Widgets/ActionDialog/action_dialog.dart';
import '../../../../../Widgets/datetime_input/datetime_input.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../Account/account.dart';
import '../../../work_manage.dart';

part 'add_work_logic.dart';

class AddWork extends StatefulWidget {
  final WorkModel? work;
  final bool check;
  const AddWork({Key? key, required this.work, required this.check})
      : super(key: key);

  @override
  State<AddWork> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  late AddWorkLogic addWorkLogic;
  late WorkModel workModel;
  @override
  void initState() {
    addWorkLogic = AddWorkLogic(context: context);
    if (widget.work != null) {
      workModel = widget.work!;
    } else {
      workModel = WorkModel(
          id: 0,
          progress: 0,
          userId: 0,
          name: "",
          status: "",
          type: "",
          priority: "",
          starting: null,
          ending: null,
          size: "",
          rate: "",
          detail: "",
          createdAt: null,
          updatedAt: null,
          ds_user: []);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addWorkLogic,
      child: Consumer<AddWorkLogic>(builder: (_, logic, __) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
                iconTheme: const IconThemeData(color: AppColors.textBlueBlack),
                backgroundColor: AppColors.white,
                title: Text(
                  workModel.name!.isEmpty ? "Thêm công việc" : workModel.name!,
                  style: const TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: [
                  if (widget.check)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.person_add_alt_rounded,
                        ),
                        onPressed: () {
                          showPopupAddUser(context, workModel.id);
                        },
                      ),
                    )
                ]),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: 80 / 1.6,
                        child: TextField(
                          controller: logic.controllerTitle,
                          onChanged: (text) {
                            workModel.name = logic.controllerTitle.text;
                          },
                          style: const TextStyle(
                            color: AppColors.textBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundColor,
                            enabled: true,
                            border: InputBorder.none,
                            hintText: workModel.name!.isEmpty
                                ? "Thêm tên công việc"
                                : workModel.name,
                            hintStyle: const TextStyle(
                              color: AppColors.textBlack,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                      child: Divider(
                        color: AppColors.black,
                        height: 0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: 150 / 1.6,
                        child: TextField(
                          controller: logic.controllerMota,
                          onChanged: (text) {
                            workModel.detail = logic.controllerMota.text;
                          },
                          style: const TextStyle(
                            color: AppColors.textBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundColor,
                            enabled: true,
                            border: InputBorder.none,
                            hintText: workModel.status!.isEmpty
                                ? "Thêm mô tả"
                                : workModel.status,
                            hintStyle: const TextStyle(
                              color: AppColors.textBlack,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          maxLines: 150 ~/ 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.030,
                    ),
                    if (widget.work != null)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: workModel.ds_user!.isNotEmpty ? 166 : 60,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 60,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Các thành viên ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                              color: AppColors.textBlack,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                                if (workModel.ds_user!.isNotEmpty)
                                  SizedBox(
                                    height: 106,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: workModel.ds_user!.length,
                                        itemBuilder: ((context, index) {
                                          return SizedBox(
                                            width: 90,
                                            child: Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: SizedBox(
                                                  height: 60,
                                                  width: 60,
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            36),
                                                                border:
                                                                    Border.all(
                                                                  color: AppColors
                                                                      .textLightGray,
                                                                  width: 2,
                                                                )),
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(36),
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          child: Image.network(
                                                            workModel
                                                                    .ds_user![
                                                                        index]
                                                                    .avatar ??
                                                                "",
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (_, __, ___) {
                                                              return Image
                                                                  .asset(Assets
                                                                      .images
                                                                      .avatarNull
                                                                      .path);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (context
                                                                    .read<
                                                                        AccountLogic>()
                                                                    .user!
                                                                    .id ==
                                                                widget.work!
                                                                    .userId) {
                                                              actionDialog(
                                                                  context,
                                                                  "Bạn có muốn xóa thành viên này?",
                                                                  icon: Icons
                                                                      .question_mark_outlined,
                                                                  cancel: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }, yes: () {
                                                                logic.deleteUserWork(
                                                                    workModel
                                                                        .ds_user![
                                                                            index]
                                                                        .pivot
                                                                        .id);
                                                                workModel.ds_user!.removeWhere((element) =>
                                                                    element
                                                                        .pivot
                                                                        .id ==
                                                                    workModel
                                                                        .ds_user![
                                                                            index]
                                                                        .pivot
                                                                        .id);
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            } else {
                                                              NotifyHelper
                                                                  .showSnackBar(
                                                                      "Bạn khoogn được thực hiện chức năng này");
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  AppColors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          36),
                                                            ),
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    workModel.ds_user![index]
                                                        .fullname,
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .textBlueBlack,
                                                        fontSize: 16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              )
                                            ]),
                                          );
                                        })),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Ngày bắt đầu",
                                  style: TextStyle(
                                      color: AppColors.textBlueBlack,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                          DateTimeInput(
                            date: workModel.starting ?? "",
                            checkDateTaskorWork: false,
                            onCheck: (value) {
                              setState(() {
                                workModel.starting = value;
                              });
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Ngày kết thúc",
                                  style: TextStyle(
                                      color: AppColors.textBlueBlack,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                          DateTimeInput(
                            date: workModel.ending ?? "",
                            checkDateTaskorWork: false,
                            onCheck: (value) {
                              setState(() {
                                workModel.ending = value;
                              });
                            },
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Text(
                          //       "Chọn màu nền",
                          //       style: TextStyle(color: AppColors.textBlack),
                          //     ),
                          //   ),
                          // ),
                          //const PickColor(),
                        ],
                      ),
                    ),
                    if (workModel.name!.isEmpty)
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
                    if (workModel.starting != null &&
                        workModel.ending != null &&
                        DateFormat('dd/MM/yyyy')
                                .parse(workModel.ending!)
                                .difference(DateFormat('dd/MM/yyyy')
                                    .parse(workModel.starting!))
                                .inDays <
                            0)
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20.0),
                            textStyle: const TextStyle(fontSize: 25),
                            primary: workModel.name!.isNotEmpty &&
                                    workModel.starting != null &&
                                    workModel.ending != null &&
                                    DateFormat('dd/MM/yyyy')
                                            .parse(workModel.ending!)
                                            .difference(DateFormat('dd/MM/yyyy')
                                                .parse(workModel.starting!))
                                            .inDays >=
                                        0
                                ? AppColors.primary
                                : AppColors.gray,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                          ),
                          onPressed: () async {
                            if (workModel.name!.isNotEmpty &&
                                workModel.starting!.isNotEmpty &&
                                workModel.ending!.isNotEmpty &&
                                DateFormat('dd/MM/yyyy')
                                        .parse(workModel.ending!)
                                        .difference(DateFormat('dd/MM/yyyy')
                                            .parse(workModel.starting!))
                                        .inDays >=
                                    0) {
                              if (!widget.check) {
                                await logic.createWork(
                                    workModel.name!,
                                    "Vừa",
                                    workModel.starting!,
                                    workModel.ending!,
                                    "Vừa",
                                    workModel.detail!);
                                context.read<WorkManagementLogic>().getData();
                                Navigator.pop(context);
                              } else {
                                await logic.editWork(
                                    workModel.id,
                                    workModel.name,
                                    workModel.priority,
                                    workModel.starting,
                                    workModel.ending,
                                    workModel.size,
                                    workModel.detail);
                                context.read<WorkManagementLogic>().getData();
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: const Text(
                            "Lưu",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
