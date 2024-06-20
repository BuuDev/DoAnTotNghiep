import 'dart:math';

import 'package:demo_retrofit_api/models/user/user.dart';
import 'package:demo_retrofit_api/models/work/work.dart';
import 'package:demo_retrofit_api/screens/app/homePage/home_page.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/add_work/pick_color/pick_color.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/add_work/popup_add_work.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../main.dart';
import '../../../../../../theme/color.dart';
import '../../../../../../widget/datetime_input/datetime_input.dart';
import '../../../../../../widget/popup_confirm/popup_confirm.dart';

part 'add_work_logic.dart';

class AddWork extends StatefulWidget {
  final int? id;
  AddWork({Key? key, this.id}) : super(key: key);

  @override
  State<AddWork> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  late AddWorkLogic addWorkLogic;
  WorkModel workModel = WorkModel(
      id: 0,
      userId: 0,
      name: "name",
      status: null,
      type: null,
      priority: null,
      starting: null,
      ending: null,
      size: null,
      rate: null,
      detail: null,
      background: null,
      createdAt: null,
      updatedAt: null,
      deletedAt: null);
  late HomePageLogic homePageLogic;
  @override
  void initState() {
    addWorkLogic = context.read<AddWorkLogic>();
    homePageLogic = context.read<HomePageLogic>();
    for (int i = 0; i < homePageLogic.item.length; i++) {
      if (homePageLogic.item[i].id == widget.id) {
        workModel = homePageLogic.item[i];
      }
    }
    super.initState();
  }

  Widget Button(String textButton) {
    return SizedBox(
      width: MediaQuery.of(context).size.height * 0.2,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20.0),
          primary: AppColors.primary,
          textStyle: const TextStyle(fontSize: 25),
          backgroundColor: AppColors.primary,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
        child: Text(
          textButton,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget TextFieldTask(String hintText, double height) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: height / 1.6,
        child: TextFormField(
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: AppColors.textBlack,
              ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.backgroundColor,
            enabled: true,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: AppColors.textBlack,
                ),
          ),
          maxLines: height ~/ 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.textBlueBlack),
          backgroundColor: AppColors.white,
          title: Text(
            widget.id == null ? "Thêm công việc" : workModel.name,
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: IconButton(
                icon: Icon(
                  Icons.person_add_alt_rounded,
                ),
                onPressed: () {
                  showPopupAddWork(context);
                },
              ),
            ),
          ]),
      body: Consumer<AddWorkLogic>(builder: (_, logic, __) {
        return SingleChildScrollView(
          child: Container(
            color: AppColors.appBg,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextFieldTask(
                    widget.id == null ? "Thêm tên công việc" : workModel.name,
                    80),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                  child: Divider(
                    color: AppColors.black,
                    height: 0,
                  ),
                ),
                TextFieldTask(
                    workModel.status == null
                        ? "Thêm một mô tả "
                        : workModel.status!,
                    150),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.030,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: AppColors.primary,
                                ),
                                SizedBox(
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
                          SizedBox(
                            height: 90,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: logic.lstSearchUser!.length,
                                itemBuilder: ((context, index) {
                                  return Column(children: [
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
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(36),
                                                  border: Border.all(
                                                    color:
                                                        AppColors.textLightGray,
                                                    width: 2,
                                                  )),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(36),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: Image.asset(
                                                  "assets/icon/avatar.png",
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  PopupComfirm(context,
                                                      "Bạn muốn loại thành viên này khỏi nhóm",
                                                      (() {
                                                    logic.confirm(context);
                                                  }));
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
                                                  child: Center(
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
                                    Text(logic.lstSearchUser![index].name,
                                        style: TextStyle(
                                            color: AppColors.textBlueBlack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))
                                  ]);
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ngày bắt đầu",
                            style: TextStyle(color: AppColors.textBlack),
                          ),
                        ),
                      ),
                      DateTimeInput(
                        date: widget.id == null ? null : workModel.starting,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ngày kết thúc",
                            style: TextStyle(color: AppColors.textBlack),
                          ),
                        ),
                      ),
                      DateTimeInput(
                        date: widget.id == null ? null : workModel.ending,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Chọn màu nền",
                            style: TextStyle(color: AppColors.textBlack),
                          ),
                        ),
                      ),
                      PickColor(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Button("Thêm"),
              ],
            ),
          ),
        );
      }),
    );
  }
}
