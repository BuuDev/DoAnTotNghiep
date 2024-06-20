import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/level/task.dart/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../Config/Colors/colors.dart';
import '../../../../../../../Models/workManage/userwork/user_work.dart';
import '../../../../../../../Widgets/ActionDialog/action_dialog.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../work.dart';

Future showPopupAddTask(BuildContext context, int workId) {
  late TaskLogic taskLogic;
  late WorkLogic workLogic;
  taskLogic = context.read<TaskLogic>();
  workLogic = context.read<WorkLogic>();
  return showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: AppColors.appBg.withOpacity(0.19),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      backgroundColor: AppColors.appBg,
      context: context,
      builder: (builder) {
        return ChangeNotifierProvider.value(
          value: workLogic,
          child: Consumer<WorkLogic>(builder: (_, logic, __) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 30, bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Builder(builder: (context) {
                return SizedBox(
                  height: 350,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible:
                                logic.checkFocus && logic.lstAddUser.isEmpty,
                            child: Text(
                              "Thêm thành viên ",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    fontFamily:
                                        Assets.googleFonts.montserratBold,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textBlack,
                                    fontSize: 22,
                                  ),
                            ),
                          ),
                          Visibility(
                            visible:
                                logic.checkFocus && logic.lstAddUser.isEmpty,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 30),
                              child: Text(
                                "Nhập tên thành viên vào ô phía dưới ",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      fontFamily:
                                          Assets.googleFonts.montserratBlack,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textBlack,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: TextField(
                              //controller: logic.controllerSearch,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: AppColors.black,
                                  ),
                              onChanged: (text) {
                                logic.changdeCheck(text);
                                logic.setLstHienThi(text.toLowerCase());
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
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
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
                          Selector<WorkLogic, List<UserWork>?>(
                              selector: (_, state) =>
                                  state.lstUserSearchHienThi,
                              builder: (_, lst, __) {
                                return lst!.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                            logic.lstAddUser.isNotEmpty
                                                ? "Thêm danh sách thành viên"
                                                : "Không có kết quả tìm kiếm!",
                                            style: TextStyle(
                                                color:
                                                    logic.lstAddUser.isNotEmpty
                                                        ? AppColors.primary
                                                        : AppColors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                      )
                                    : SizedBox(
                                        height: 100,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: lst.length,
                                          itemBuilder: ((context, index) {
                                            return SizedBox(
                                              width: 80,
                                              child: Column(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                                  border: Border
                                                                      .all(
                                                                    color: AppColors
                                                                        .textLightGray,
                                                                    width: 2,
                                                                  )),
                                                          child: Material(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        36),
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child:
                                                                Image.network(
                                                              lst[index]
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
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: InkWell(
                                                            onTap: () {
                                                              logic.addUser(
                                                                  lst[index].id,
                                                                  workId);
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .lightGray,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            36),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .textBlueBlack,
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
                                                Text(lst[index].fullname,
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .textBlueBlack,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400))
                                              ]),
                                            );
                                          }),
                                        ),
                                      );
                              }),
                          if (logic.lstAddUser.isNotEmpty)
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: logic.lstAddUser.length,
                                itemBuilder: ((context, index) {
                                  return SizedBox(
                                    width: 80,
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            36),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .textLightGray,
                                                      width: 2,
                                                    )),
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(36),
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  child: Image.network(
                                                    logic.lstAddUser[index]
                                                            .avatar ??
                                                        "",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (_, __, ___) {
                                                      return Image.asset(Assets
                                                          .images
                                                          .avatarNull
                                                          .path);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    logic.deleteUser(logic
                                                        .lstAddUser[index].id);
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              36),
                                                    ),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: AppColors.white,
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
                                      Text(logic.lstAddUser[index].fullname,
                                          style: const TextStyle(
                                              color: AppColors.textBlueBlack,
                                              fontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w400))
                                    ]),
                                  );
                                }),
                              ),
                            ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.height * 0.2,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(20.0),
                                  primary: AppColors.primary,
                                  textStyle: const TextStyle(fontSize: 25),
                                  backgroundColor: AppColors.primary,
                                ),
                                onPressed: () {
                                  actionDialog(context,
                                      "Bạn có muốn thêm các thành viên này này?",
                                      icon: Icons.question_mark_outlined,
                                      cancel: () {
                                    Navigator.pop(context);
                                  }, yes: () async {
                                    await taskLogic.assignUser(
                                        workId, logic.lstAddUser);
                                    Navigator.pop(context);
                                    // context
                                    //     .read<WorkManagementLogic>()
                                    //     .getData();
                                  }).then((value) => Navigator.pop(context));
                                },
                                child: const Text(
                                  "Thêm",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                );
              }),
            );
          }),
        );
      });
}
