import 'package:demo_retrofit_api/gen/assets.gen.dart';
import 'package:demo_retrofit_api/screens/authentication/forgot_pass/otp_password.dart';
import 'package:demo_retrofit_api/screens/authentication/login/login.dart';
import 'package:demo_retrofit_api/widget/textfield/textfield_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/color.dart';
import '../../../widget/appbar_back/appbarback.dart';

class ForgotPassWord extends StatefulWidget {
  const ForgotPassWord({Key? key}) : super(key: key);

  @override
  State<ForgotPassWord> createState() => _ForgotPassWordState();
}

class _ForgotPassWordState extends State<ForgotPassWord> {
  late LoginLogic loginLogic;
  @override
  void initState() {
    loginLogic = context.read<LoginLogic>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: loginLogic,
      child: Consumer<LoginLogic>(builder: (_, logic, __) {
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
                  "Đặt lại mật khẩu",
                  style: TextStyle(
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    fontFamily: Assets.fonts.montserratBlack,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Text(
                    "Vui lòng nhập email đã đăng ký",
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: Assets.fonts.montserratBlack,
                    ),
                  ),
                ),
                TextFiledLogin(
                  onChanged: (text) {},
                  controller: logic.passwordController,
                  context: context,
                  Subtext: "Email",
                  hintText: "Email",
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
                        MaterialPageRoute(
                            builder: (context) => OTPPagePassWord()),
                      );
                    },
                    child: const Text(
                      "Đăng nhập",
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
      }),
    );
  }
}
