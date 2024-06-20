import 'package:demo_retrofit_api/screens/authentication/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../gen/assets.gen.dart';
import '../../../theme/color.dart';
import '../../../widget/appbar_back/appbarback.dart';
import '../../../widget/textfield/textfield_login.dart';

class ResetPassWord extends StatefulWidget {
  const ResetPassWord({Key? key}) : super(key: key);

  @override
  State<ResetPassWord> createState() => _ResetPassWordState();
}

class _ResetPassWordState extends State<ResetPassWord> {
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
                      fontWeight: FontWeight.w700,
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
            child: SingleChildScrollView(
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  TextFiledLogin(
                    onChanged: (text) {},
                    controller: logic.passwordController,
                    context: context,
                    Subtext: "Mật khẩu",
                    hintText: "Mật khẩu",
                    color: AppColors.textBlack,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextFiledLogin(
                    onChanged: (text) {},
                    controller: logic.returnPasswordController,
                    context: context,
                    Subtext: "Nhập lại mật khẩu",
                    hintText: "Nhập lại mật khẩu",
                    color: AppColors.textBlack,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
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
                          MaterialPageRoute(builder: (context) => Login()),
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
          ),
        );
      }),
    );
  }
}
