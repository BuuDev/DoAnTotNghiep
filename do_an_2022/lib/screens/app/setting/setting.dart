import 'package:demo_retrofit_api/screens/app/setting/change_password/change_password.dart';
import 'package:demo_retrofit_api/screens/app/setting/profile/profile_info.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/auth_loading.dart';
import '../../../widget/custom_expansion_tile/custom_expansion_tile.dart';
import '../homePage/home_page.dart';
part 'setting_logic.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late SettingLogic settingLogic;
  @override
  void initState() {
    settingLogic = context.read<SettingLogic>();
    super.initState();
  }

  Widget boxWidget({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 15, right: 15, top: 5),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: AppColors.white,
        child: child,
      ),
    );
  }

  Widget titleSetting(String title) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 15),
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: AppColors.textBlueBlack,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: settingLogic,
      child: Consumer<SettingLogic>(builder: (_, logic, __) {
        return Scaffold(
          backgroundColor: AppColors.lightGray,
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(children: [
                titleSetting("Dự án đang tham gia"),
                boxWidget(
                  child: CustomExpansionTile(
                    onExpansionChanged: (value) {},
                    icons: Icons.library_books,
                    title: "Dự án",
                    index: 2,
                    children: [],
                  ),
                ),
                titleSetting("Tài khoản"),
                boxWidget(
                  child: CustomExpansionTile(
                    onExpansionChanged: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileInfo()),
                      );
                    },
                    icons: Icons.person,
                    title: "Hồ sơ và hiển thị",
                    index: 2,
                    children: [],
                  ),
                ),
                boxWidget(
                  child: CustomExpansionTile(
                    onExpansionChanged: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassWord()),
                      );
                    },
                    icons: Icons.people,
                    title: "Đổi mật khẩu",
                    index: 2,
                    children: [],
                  ),
                ),

                titleSetting("Cài đặt"),
                boxWidget(
                  child: CustomExpansionTile(
                    onExpansionChanged: (value) {},
                    icons: Icons.notifications,
                    title: "Thông báo",
                    index: 2,
                    children: [
                      ListTile(
                        title: Text(
                          "Thông báo công việc",
                          style: TextStyle(
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                boxWidget(
                  child: CustomExpansionTile(
                    onExpansionChanged: (value) async {
                      logic.removeTokenUser();
                      await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthLoadingPage()),
                          ((route) => false));
                    },
                    icons: Icons.logout,
                    trailing: Icon(Icons.arrow_forward),
                    title: "Đăng xuất",
                    index: 2,
                    children: [],
                  ),
                ),
                // boxWidget(
                //   child: CustomExpansionTile(
                //     onExpansionChanged: (value) {},
                //     icons: Icons.notifications,
                //     title: "Notification",
                //     index: 2,
                //     children: [],
                //   ),
                // ),
                // boxWidget(
                //   child: CustomExpansionTile(
                //     onExpansionChanged: (value) {},
                //     icons: Icons.notifications,
                //     title: "Notification",
                //     index: 2,
                //     children: [],
                //   ),
                // ),
                // boxWidget(
                //   child: CustomExpansionTile(
                //     onExpansionChanged: (value) {},
                //     icons: Icons.notifications,
                //     title: "Notification",
                //     index: 2,
                //     children: [],
                //   ),
                // ),
                // SizedBox(
                //   height: 70,
                // )
                // Padding(
                //   padding: const EdgeInsets.only(
                //       top: 50, bottom: 70, left: 15, right: 15),
                //   child: SizedBox(
                //     width: double.infinity,
                //     height: 49,
                //     child: ElevatedButton(
                //       onPressed: () {},
                //       child: Text(
                //         "Đăng nhập",
                //         style: Theme.of(context).textTheme.subtitle1!.copyWith(
                //             color: AppColors.textBlueBlack, fontWeight: FontWeight.bold),
                //       ),
                //       style: ElevatedButton.styleFrom(
                //           primary: AppColors.white,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(8),
                //           ),
                //           padding: EdgeInsets.zero),
                //     ),
                //   ),
                //),
              ]),
            ),
          ),
        );
      }),
    );
  }
}
