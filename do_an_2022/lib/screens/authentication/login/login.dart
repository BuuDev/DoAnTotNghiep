import 'dart:async';

import 'package:demo_retrofit_api/gen/assets.gen.dart';
import 'package:demo_retrofit_api/main.dart';

import 'package:demo_retrofit_api/theme/color.dart';
import 'package:demo_retrofit_api/widget/textfield/textfield_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/user_info/user_info.dart';
import '../../../service/api/api_client.dart';
import '../../../service/api/local_storage.dart';
import '../../../service/api/user/user.dart';
import '../forgot_pass/forgot_password.dart';
part 'login_logic.dart';
// import '../logout/signin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginLogic loginLogic;

  @override
  void initState() {
    loginLogic = context.read<LoginLogic>();
    super.initState();
  }

  Widget ButtonLogin(String textButton) {
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
          loginLogic.setTokenUser();
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
      value: loginLogic,
      child: Consumer<LoginLogic>(builder: (_, logic, __) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColors.appBg,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Text(
                    "Đăng nhập",
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  TextFiledLogin(
                    onChanged: (text) {},
                    controller: logic.emailController,
                    context: context,
                    Subtext: "Email",
                    hintText: "Email",
                    color: AppColors.textBlack,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextFiledLogin(
                    onChanged: (text) {},
                    controller: logic.passwordController,
                    context: context,
                    obscure: true,
                    Subtext: "Mật khẩu",
                    hintText: "Mật khẩu",
                    color: AppColors.textBlack,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  ButtonLogin("Đăng nhập"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassWord(),
                              ),
                            ),
                          },
                          child: const Text(
                            "Quên mật khẩu",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(children: [
                      const Expanded(
                        child: Divider(color: AppColors.silvergrey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "hoặc",
                          style: Theme.of(context).textTheme.subtitle1!.merge(
                                const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.silvergrey,
                                ),
                              ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: AppColors.silvergrey),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        primary: AppColors.primary,
                        textStyle: const TextStyle(fontSize: 25),
                        backgroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => MyApp()),
                        // );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.icon.google,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          const Text(
                            "Tiếp tục với Google",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
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
