import 'dart:io';

import 'package:demo_retrofit_api/gen/assets.gen.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:demo_retrofit_api/widget/textfield/textfield_login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../../widget/appbar_back/appbarback.dart';
part "profile_info.logic.dart";

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late ProfileLogic _profileLogic;
  @override
  void initState() {
    super.initState();
    _profileLogic = context.read<ProfileLogic>();
  }

  Widget Button(String textButton) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _profileLogic,
      child: Consumer<ProfileLogic>(builder: (_, logic, __) {
        return Scaffold(
          appBar: AppBarWidget(
            colorIcon: AppColors.silvergrey,
            centerTitle: false,
            customTitle: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(0),
                child: Text("Quay lại",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.silvergrey,
                    )),
              ),
            ),
            backgroundColor: AppColors.appBg,
          ),
          backgroundColor: AppColors.appBg,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Thông tin cá nhân",
                    style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontFamily: Assets.fonts.montserratBlack),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: InkWell(
                      onTap: (() {
                        logic.getSingleImage();
                      }),
                      child: logic.images == null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70),
                                  color: AppColors.white,
                                  border:
                                      Border.all(color: AppColors.textBlack)),
                              width: 130,
                              height: 130,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: AppColors.textBlack,
                                size: 50,
                              ),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  FileImage(File(logic.images!.path)),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  TextFiledLogin(
                      context: context,
                      Subtext: "Đổi tên",
                      hintText: "Tên",
                      color: AppColors.textBlack),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  TextFiledLogin(
                    context: context,
                    Subtext: "Đổi năm sinh",
                    hintText: "Nhập năm sinh",
                    color: AppColors.textBlack,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  TextFiledLogin(
                    context: context,
                    Subtext: "Đổi quốc gia",
                    hintText: "Nhập quốc gia",
                    color: AppColors.textBlack,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  TextFiledLogin(
                    context: context,
                    Subtext: "Đổi số điện thoại",
                    hintText: "SĐT",
                    color: AppColors.textBlack,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.050,
                  ),
                  Button("Hoàn tất"),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
