import 'package:demo_retrofit_api/gen/assets.gen.dart';
import 'package:demo_retrofit_api/screens/authentication/forgot_pass/otp_password.dart';
import 'package:demo_retrofit_api/widget/textfield/textfield_login.dart';
import 'package:flutter/material.dart';

import '../../../../theme/color.dart';
import '../../../../widget/appbar_back/appbarback.dart';

class ChangePassWord extends StatefulWidget {
  const ChangePassWord({Key? key}) : super(key: key);

  @override
  State<ChangePassWord> createState() => _ChangePassWordState();
}

class _ChangePassWordState extends State<ChangePassWord> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        color: AppColors.appBg,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "Đổi mật khẩu",
              style: TextStyle(
                color: AppColors.textBlack,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontFamily: Assets.fonts.montserratBlack,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 15),
              child: TextFiledLogin(
                context: context,
                Subtext: "Mật khẩu cũ",
                hintText: "Mật khẩu cũ",
                color: AppColors.textBlack,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextFiledLogin(
                context: context,
                Subtext: "Mật khẩu mới",
                hintText: "Mật khẩu mới",
                color: AppColors.textBlack,
              ),
            ),
            TextFiledLogin(
              context: context,
              Subtext: "Nhập lại Mật khẩu mới",
              hintText: "Nhập lại Mật khẩu mới",
              color: AppColors.textBlack,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  primary: AppColors.textLightGrayDisabled,
                  textStyle: const TextStyle(fontSize: 25),
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OTPPagePassWord()),
                  );
                },
                child: const Text(
                  "Hoàn tất",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
