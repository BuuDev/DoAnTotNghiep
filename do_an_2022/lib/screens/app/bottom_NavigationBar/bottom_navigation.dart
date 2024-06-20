import 'package:demo_retrofit_api/gen/assets.gen.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homePage/home_page.dart';

class CustomBottomNavigation extends StatefulWidget {
  CustomBottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => CustomBottomNavigationState();
}

class CustomBottomNavigationState extends State<CustomBottomNavigation> {
  late HomePageLogic homePageLogic;

  static double heightInsets(BuildContext context) {
    double insets = MediaQuery.of(context).viewPadding.bottom;
    // double extraHeight = insets > 0 ? 10 : 0;
    // Platform.isIOS ? extraHeight :
    return insets;
  }

  @override
  void initState() {
    super.initState();
    homePageLogic = context.read<HomePageLogic>();
  }

  // @override
  // void dispose() {
  //   homePageLogic.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageLogic, int>(
      selector: (_, state) => state.index,
      builder: (_, value, __) {
        return Container(
          height: 60,
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 173, 171, 171), blurRadius: 5)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  homePageLogic.changeIndex(0);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      child: Icon(
                        Icons.home_outlined,
                        color: value == 0
                            ? AppColors.primary
                            : AppColors.textTertiary,
                      ),
                    ),
                    Text(
                      'Trang chủ',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: value == 0
                                ? AppColors.primary
                                : AppColors.textTertiary,
                            fontFamily: Assets.fonts.montserratBold,
                            fontWeight: value == 0 ? FontWeight.bold : null,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  homePageLogic.changeIndex(1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.notifications_on_outlined,
                        color: value == 1
                            ? AppColors.primary
                            : AppColors.textTertiary,
                      ),
                    ),
                    Text(
                      'Thông báo',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: value == 1
                                ? AppColors.primary
                                : AppColors.textTertiary,
                            fontFamily: Assets.fonts.montserratBold,
                            fontWeight: value == 1 ? FontWeight.bold : null,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  homePageLogic.changeIndex(2);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.settings_outlined,
                        color: value == 2
                            ? AppColors.primary
                            : AppColors.textTertiary,
                      ),
                    ),
                    Text(
                      'Cài đặt',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: value == 2
                                ? AppColors.primary
                                : AppColors.textTertiary,
                            fontFamily: Assets.fonts.montserratBold,
                            fontWeight: value == 2 ? FontWeight.bold : null,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
