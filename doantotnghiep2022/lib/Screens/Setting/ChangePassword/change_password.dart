import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/Account/account.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/LabelCustom/label_textfield_custom.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'change_password_logic.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late ChangePasswordLogic changePasswordLogic;
  @override
  void initState() {
    super.initState();
    changePasswordLogic = ChangePasswordLogic();
  }

  @override
  void dispose() {
    changePasswordLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: changePasswordLogic,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          title: const Text(
            'Thay đổi mật khẩu',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textBlack,
                size: 15,
              )),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: Image.asset(Assets.images.loginBg.path),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const LabelTextFieldCustom(value: 'Mật khẩu cũ'),
                const SizedBox(
                  height: 5,
                ),
                Consumer<ChangePasswordLogic>(
                  builder: (_, value, __) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldCustom(
                          value: changePasswordLogic.password,
                          typePassword: !changePasswordLogic.showPassword,
                          errorBorder:
                              changePasswordLogic.password.trim().isNotEmpty &&
                                  changePasswordLogic.errorPassword.isNotEmpty,
                          onChanged: (val) {
                            changePasswordLogic.update('1', val);
                          },
                          placeholder: 'Nhập mật khẩu...',
                          suFFixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              changePasswordLogic.password.trim().isNotEmpty &&
                                      changePasswordLogic
                                          .errorPassword.isNotEmpty
                                  ? const Icon(
                                      Icons.warning_amber_rounded,
                                      size: 20,
                                      color: AppColors.red,
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    changePasswordLogic.showPass('1');
                                  },
                                  child: Icon(
                                    !changePasswordLogic.showPassword
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.tertiary,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        if (changePasswordLogic.errorPassword.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(changePasswordLogic.errorPassword,
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 14,
                                  fontFamily: Assets.googleFonts.montserratBold,
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                      ],
                    );
                  },
                ),
                //mật khẩu mới

                const LabelTextFieldCustom(value: 'Mật khẩu mới'),
                const SizedBox(
                  height: 5,
                ),
                Consumer<ChangePasswordLogic>(
                  builder: (_, value, __) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldCustom(
                          value: changePasswordLogic.newPassword,
                          typePassword: !changePasswordLogic.showPassword2,
                          errorBorder: changePasswordLogic.newPassword
                                  .trim()
                                  .isNotEmpty &&
                              changePasswordLogic.errorNewPassword.isNotEmpty,
                          onChanged: (val) {
                            changePasswordLogic.update('2', val);
                          },
                          placeholder: 'Nhập mật khẩu mới...',
                          suFFixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              changePasswordLogic.newPassword
                                          .trim()
                                          .isNotEmpty &&
                                      changePasswordLogic
                                          .errorNewPassword.isNotEmpty
                                  ? const Icon(
                                      Icons.warning_amber_rounded,
                                      size: 20,
                                      color: AppColors.red,
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    changePasswordLogic.showPass('2');
                                  },
                                  child: Icon(
                                    !changePasswordLogic.showPassword2
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.tertiary,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        if (changePasswordLogic.errorNewPassword.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(changePasswordLogic.errorNewPassword,
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 14,
                                  fontFamily: Assets.googleFonts.montserratBold,
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                      ],
                    );
                  },
                ),
                const LabelTextFieldCustom(value: 'Nhập lại mật khẩu mới'),
                const SizedBox(
                  height: 5,
                ),
                Consumer<ChangePasswordLogic>(
                  builder: (_, value, __) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldCustom(
                          value: changePasswordLogic.confirmPassword,
                          typePassword: !changePasswordLogic.showPassword3,
                          errorBorder: changePasswordLogic.confirmPassword
                                  .trim()
                                  .isNotEmpty &&
                              changePasswordLogic
                                  .errorConfirmPassword.isNotEmpty,
                          onChanged: (val) {
                            changePasswordLogic.update('3', val);
                          },
                          placeholder: 'Nhập lại mật khẩu mới...',
                          suFFixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              changePasswordLogic.confirmPassword
                                          .trim()
                                          .isNotEmpty &&
                                      changePasswordLogic
                                          .errorConfirmPassword.isNotEmpty
                                  ? const Icon(
                                      Icons.warning_amber_rounded,
                                      size: 20,
                                      color: AppColors.red,
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    changePasswordLogic.showPass('3');
                                  },
                                  child: Icon(
                                    !changePasswordLogic.showPassword3
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.tertiary,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        if (changePasswordLogic.errorConfirmPassword.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                                changePasswordLogic.errorConfirmPassword,
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 14,
                                  fontFamily: Assets.googleFonts.montserratBold,
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<ChangePasswordLogic>(
                  builder: (_, value, __) {
                    return InkWell(
                      onTap: () {
                        changePasswordLogic.changePassword(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: changePasswordLogic.activeButton
                                ? const Color(0xff009688)
                                : AppColors.tertiary),
                        child: const Center(
                          child: Text('Thay đổi mật khẩu',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
