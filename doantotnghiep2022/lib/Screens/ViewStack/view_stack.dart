import 'dart:io';
import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:doantotnghiep/Models/demoModels/demo_model.dart';
import 'package:doantotnghiep/Screens/Account/account.dart';
import 'package:doantotnghiep/Screens/HomePage/home.dart';
import 'package:doantotnghiep/Screens/Setting/setting.dart';
import 'package:doantotnghiep/Screens/TimekeepingTimekeeping/timekeeping.dart';
import 'package:doantotnghiep/Screens/dark_mode_provider.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Services/LocalStorage/local_storage.dart';
import 'package:doantotnghiep/Widgets/AppBarMain/appbar_main.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../WorkManagement/work_manage.dart';
part 'view_stack_logic.dart';

class ViewStack extends StatefulWidget {
  const ViewStack({Key? key}) : super(key: key);

  @override
  State<ViewStack> createState() => _ViewStackState();
}

class _ViewStackState extends State<ViewStack>
    with SingleTickerProviderStateMixin {
  static ViewStackLogic viewStackLogic = ViewStackLogic();
  late AccountLogic accountLogic;
  @override
  void initState() {
    viewStackLogic = ViewStackLogic();
    accountLogic = context.read<AccountLogic>();
    LocalStorage().store.setString('status', '');
    super.initState();
  }

  @override
  void dispose() {
    viewStackLogic.dispose();
    //accountLogic.dispose();
    super.dispose();
  }

  List<Widget> page = [
    const HomePage(),
    // const AdminHomeNewUI(),
    const WorkManagement(),
    const TimekeepingSceen(),
    const SettingScreen(),
    // const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ChangeNotifierProvider.value(
        value: viewStackLogic,
        child: Scaffold(
          extendBody: true,
          backgroundColor:
              context.watch<DarkModeProvider>().darkmode ? Colors.grey : null,
          //resizeToAvoidBottomInset: false,
          appBar: appBarMain(
            Selector<AccountLogic, Tuple2<File?, UserDemo?>>(
              selector: (_, state) => Tuple2(
                state.imageShow,
                state.user,
              ),
              builder: (_, value, __) {
                return value.item2 == null
                    ? Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xff009688).withOpacity(0.7),
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child:
                            const Center(child: CupertinoActivityIndicator()),
                      )
                    : Selector<ViewStackLogic, bool>(
                        selector: (_, state) => state.isShowImageNetwork,
                        builder: (_, value, __) {
                          return Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 158, 182, 245),
                                border: Border.all(
                                  color:
                                      const Color(0xff009688).withOpacity(0.7),
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                                image: accountLogic.user!.avatar != null &&
                                        accountLogic.imageShow == null
                                    ? value
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              accountLogic.user!.avatar!,
                                            ),
                                            onError: (_, __) {
                                              viewStackLogic
                                                  .updateValueIshowImageNetwork();
                                            },
                                          )
                                        : DecorationImage(
                                            image: AssetImage(
                                                Assets.images.avatarNull.path))
                                    : accountLogic.imageShow != null
                                        ? DecorationImage(
                                            image: FileImage(File(
                                                accountLogic.imageShow!.path)),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: AssetImage(Assets
                                                .images.avatarNull.path))),
                          );
                        },
                      );
              },
            ),
            Selector<ViewStackLogic, String>(
              selector: (_, state) => state.title,
              builder: (_, value, __) {
                return Text(
                  value,
                  style: TextStyle(
                    color: context.watch<DarkModeProvider>().darkmode
                        ? AppColors.backgroundColor
                        : AppColors.acne4,
                    fontSize: 18,
                    fontFamily: 'Monsserat',
                  ),
                );
              },
            ),
            context.watch<DarkModeProvider>().darkmode
                ? AppColors.gray
                : AppColors.white,
            onTap: () {
              Navigator.pushNamed(context, Routes().account);
            },
            // leading: Selector<ViewStackLogic, int>(
            //   selector: (_, state) => state.index,
            //   builder: (_, value, __) {
            //     return value == 4
            //         ? IconButton(
            //             onPressed: () {
            //               viewStackLogic.changeIndexBottomNavBar(
            //                   viewStackLogic.indexStorage);
            //               FocusScope.of(context).unfocus();
            //             },
            //             icon: const Icon(
            //               Icons.arrow_back_ios,
            //               color: AppColors.textBlack,
            //               size: 15,
            //             ))
            //         : InkWell(
            //             onTap: () async {
            //               try {
            //                 await launchUrl(Uri.parse('https://didotek.vn/'));
            //               } catch (e) {
            //                 debugPrint('$e');
            //               }
            //             },
            //             child: Padding(
            //               padding: const EdgeInsets.only(left: 15),
            //               child: ClipRRect(
            //                   borderRadius: BorderRadius.circular(50),
            //                   child: Image.asset(Assets.images.iconBg.path)),
            //             ),
            //           );
            //   },
            // ),
            // leading: InkWell(
            //   onTap: () {
            //     // context.read<DarkModeProvider>().changeDarkMode();
            //   },
            //   child: const Icon(
            //     Icons.wb_sunny_outlined,
            //     color: Colors.black,
            //   ),
            // ),
          ),
          body: Selector<ViewStackLogic, int>(
            selector: (_, state) => state.index,
            builder: (_, value, __) {
              return IndexedStack(
                index: viewStackLogic.index,
                children: page,
              );
            },
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.startDocked,
          // floatingActionButton: Selector<ViewStackLogic, int>(
          //   selector: (_, state) => state.index,
          //   builder: (_, value, __) {
          //     return value != 4
          //         ? FloatingActionButton(
          //             backgroundColor: value == 0
          //                 ? context.watch<DarkModeProvider>().darkmode
          //                     ? AppColors.acneGreen
          //                     : const Color(0xff009688).withOpacity(0.7)
          //                 : AppColors.backgroundColor,
          //             //mini: true,
          //             child: Icon(Icons.house_outlined,
          //                 color: value == 0
          //                     ? AppColors.white
          //                     : AppColors.tertiary),
          //             onPressed: () {
          //               viewStackLogic.changeIndexBottomNavBar(0);
          //             },
          //           )
          //         : const SizedBox();
          //   },
          // ),
          bottomNavigationBar: Selector<ViewStackLogic, int>(
            selector: (_, state) => state.index,
            builder: (_, value, __) {
              return value != 4
                  ? Container(
                      // các thuộc tính dành cho bottomAppbar
                      // elevation: 10.0,
                      // color: AppColors.backgroundColor,
                      // shape: const CircularNotchedRectangle(),
                      // notchMargin: 7.0,
                      height: 70,
                      // margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gray,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Row(
                          //mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                viewStackLogic.changeIndexBottomNavBar(0);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      // color: value == 0
                                      //     ? const Color(0xff009688)
                                      //         .withOpacity(0.7)
                                      //     : null,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      value == 0
                                          ? Icons.home
                                          : Icons.home_outlined,
                                      color: value == 0
                                          ? const Color(0xff009688)
                                              .withOpacity(0.7)
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                  // const SizedBox(height: 5),
                                  Text(
                                    'Trang chủ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          Assets.googleFonts.montserratBold,
                                      color: value == 0
                                          ? const Color(0xff009688)
                                              .withOpacity(0.7)
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                viewStackLogic.changeIndexBottomNavBar(1);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      // color: value == 1
                                      //     ? const Color(0xff009688)
                                      //         .withOpacity(0.7)
                                      //     : null,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.pie_chart_outline,
                                      color: value == 1
                                          ? const Color(0xff009688)
                                              .withOpacity(0.7)
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                  // const SizedBox(height: 5),
                                  Text(
                                    'Công việc',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          Assets.googleFonts.montserratBold,
                                      color: value == 1
                                          ? const Color(0xff009688)
                                              .withOpacity(0.7)
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => LocalStorage().getString('role') ==
                                      'admin'
                                  ? viewStackLogic.changeIndexBottomNavBar(2)
                                  : NotifyHelper.showSnackBar(
                                      'Bạn không có quyền truy cập chức năng này!'),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      // color: value == 2
                                      //     ? const Color(0xff009688)
                                      //         .withOpacity(0.7)
                                      //     : null,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.featured_play_list_outlined,
                                      color: value == 2
                                          ? const Color(0xff009688)
                                              .withOpacity(0.7)
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                  // const SizedBox(height: 5),
                                  Text(
                                    'Chấm công',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          Assets.googleFonts.montserratBold,
                                      color: value == 2
                                          ? const Color(0xff009688)
                                              .withOpacity(0.7)
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  viewStackLogic.changeIndexBottomNavBar(3),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      // color: value == 3
                                      //     ? const Color(0xff009688)
                                      //         .withOpacity(0.7)
                                      //     : null,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.settings_outlined,
                                      color: value == 3
                                          ? const Color(0xff009688)
                                              .withOpacity(0.7)
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                  // const SizedBox(height: 5),
                                  Text(
                                    'Cài đặt',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          Assets.googleFonts.montserratBold,
                                      color: value == 3
                                          ? const Color(0xff009688)
                                              .withOpacity(0.7)
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
