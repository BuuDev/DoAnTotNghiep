import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/Account/account.dart';
import 'package:doantotnghiep/Screens/dark_mode_provider.dart';
import 'package:doantotnghiep/Services/LocalStorage/local_storage.dart';
import 'package:doantotnghiep/Widgets/CustomExpansionTile/custom_expanstiontile.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

part 'setting_logic.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late SettingLogic settingLogic;
  late DarkModeProvider darkModeProvider;
  @override
  void initState() {
    super.initState();
    settingLogic = SettingLogic(context: context);
    darkModeProvider = context.read<DarkModeProvider>();
  }

  @override
  void dispose() {
    settingLogic.dispose();
    darkModeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (context.watch<ViewStackLogic>().index == 1) {
    //   settingLogic.test();
    // }
    return ChangeNotifierProvider.value(
      value: settingLogic,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Selector<SettingLogic, Tuple2<bool, bool>>(
                selector: (_, state) =>
                    Tuple2(state.activeButtonNotifi, state.activeSwitch),
                builder: (_, value, __) {
                  return CustomExpansionTile(
                    onchange: (value) {
                      settingLogic.activeButtonNoti();
                    },
                    active: value.item1,
                    leading: Icons.notifications_none_outlined,
                    title: 'Thông báo',
                    children: [
                      ListTile(
                        leading: Consumer<DarkModeProvider>(
                          builder: (_, value, __) {
                            return Text('Cho phép gửi thông báo',
                                style: TextStyle(
                                  color: darkModeProvider.darkmode
                                      ? AppColors.white
                                      : AppColors.textBlack,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ));
                          },
                        ),
                        trailing: CupertinoSwitch(
                          value: value.item2,
                          onChanged: (value) {
                            settingLogic.activeButtonSwitch();
                          },
                          activeColor: AppColors.primary,
                        ),
                      ),
                    ],
                  );
                },
              ),
              //
              const SizedBox(
                height: 10,
              ),
              //
              CustomExpansionTile(
                title: 'Đổi mật khẩu',
                leading: Icons.lock_open_outlined,
                trailing: const Icon(Icons.arrow_forward_rounded),
                onchange: (val) {
                  Navigator.pushNamed(context, Routes().changePassword);
                },
              ),
              //
              const SizedBox(
                height: 10,
              ),
              //
              Selector<SettingLogic, Tuple2<bool, bool>>(
                selector: (_, state) => Tuple2(
                    state.activeButtonDarkMode, state.activeSwitchDarkMode),
                builder: (_, value, __) {
                  return CustomExpansionTile(
                    title: 'Chế độ tối',
                    leading: Icons.mode_night_outlined,
                    active: value.item1,
                    onchange: (val) {
                      settingLogic.activeButtonDark();
                    },
                    children: [
                      ListTile(
                        leading: Consumer<DarkModeProvider>(
                          builder: (_, value, __) {
                            return Text('Bật / Tắt',
                                style: TextStyle(
                                  color: darkModeProvider.darkmode
                                      ? AppColors.white
                                      : AppColors.textBlack,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ));
                          },
                        ),
                        trailing: CupertinoSwitch(
                          value: value.item2,
                          onChanged: (value) {
                            settingLogic.activeButtonSwitchDark();
                          },
                          activeColor: AppColors.primary,
                        ),
                      )
                    ],
                  );
                },
              ),
              //
              const SizedBox(
                height: 10,
              ),
              //
              Selector<SettingLogic, bool>(
                selector: (_, state) => state.activeButtonInfo,
                builder: (_, value, __) {
                  return CustomExpansionTile(
                    onchange: (value) {
                      settingLogic.activeButtonInf();
                    },
                    active: value,
                    title: 'Giới thiệu',
                    leading: Icons.info_outline_rounded,
                    children: [
                      ListTile(
                        leading: Consumer<DarkModeProvider>(
                          builder: (_, value, __) {
                            return Text('Thông tin liên hệ',
                                style: TextStyle(
                                  color: darkModeProvider.darkmode
                                      ? AppColors.white
                                      : AppColors.textBlack,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ));
                          },
                        ),
                        trailing: InkWell(
                          onTap: () {
                            settingLogic.openPhone('0764890345');
                          },
                          child: Consumer<DarkModeProvider>(
                            builder: (_, value, __) {
                              return Text('0764890345',
                                  style: TextStyle(
                                    color: darkModeProvider.darkmode
                                        ? AppColors.greenLight
                                        : AppColors.primary,
                                    fontSize: 13,
                                    fontFamily:
                                        Assets.googleFonts.montserratBold,
                                    fontWeight: FontWeight.bold,
                                  ));
                            },
                          ),
                        ),
                      ),
                      //
                      ListTile(
                        leading: Consumer<DarkModeProvider>(
                          builder: (_, value, __) {
                            return Text('Phiên bản',
                                style: TextStyle(
                                  color: darkModeProvider.darkmode
                                      ? AppColors.white
                                      : AppColors.textBlack,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ));
                          },
                        ),
                        trailing: Consumer<DarkModeProvider>(
                          builder: (_, value, __) {
                            return Text('1.1',
                                style: TextStyle(
                                  color: darkModeProvider.darkmode
                                      ? AppColors.greenLight
                                      : AppColors.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ));
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              //
              const SizedBox(
                height: 20,
              ),
              //Nút lưu
              InkWell(
                onTap: () {
                  context.read<AccountLogic>().logout(context);
                },
                child: Consumer<DarkModeProvider>(
                  builder: (_, value, __) {
                    return Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: darkModeProvider.darkmode
                              ? AppColors.primary
                              : AppColors.tertiary),
                      child: Center(
                        child: Text('Đăng xuất',
                            style: TextStyle(
                              color: darkModeProvider.darkmode
                                  ? AppColors.white
                                  : AppColors.textBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
