import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/Login/login.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late LoginLogic loginLogic;
  @override
  void initState() {
    loginLogic = LoginLogic(context: context);
    super.initState();
  }

  @override
  void dispose() {
    loginLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: loginLogic,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0.0,
            centerTitle: true,
            title: const Text('Quên mật khẩu',
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                )),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textBlack,
                  size: 16,
                )),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.asset(Assets.images.loginBg.path),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Vui lòng nhập email đã đăng ký tài khoản,chúng tôi sẽ gửi mã xác nhận để bạn đặt lại mật khẩu.',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Email',
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<LoginLogic>(
                    builder: (_, value, __) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldCustom(
                              errorBorder:
                                  loginLogic.txtEmail.text.trim().isNotEmpty &&
                                      loginLogic.errorEmail.isNotEmpty,
                              controller: loginLogic.txtEmail,
                              onChanged: (val) {
                                loginLogic.validateEmail(val);
                              },
                              placeholder: 'Nhập email...',
                              suFFixIcon:
                                  loginLogic.txtEmail.text.trim().isNotEmpty &&
                                          loginLogic.errorEmail.isNotEmpty
                                      ? const Icon(
                                          Icons.warning_amber_rounded,
                                          size: 20,
                                          color: AppColors.red,
                                        )
                                      : null),
                          const SizedBox(
                            height: 5,
                          ),
                          if (loginLogic.errorEmail.isNotEmpty)
                            Text(loginLogic.errorEmail,
                                style: const TextStyle(
                                  color: AppColors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ))
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff009688),
                      ),
                      child: const Center(
                        child: Text('Gửi mã xác nhận',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
