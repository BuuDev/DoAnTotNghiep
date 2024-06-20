import 'package:demo_retrofit_api/gen/assets.gen.dart';
import 'package:demo_retrofit_api/screens/app/Notifi/Notifi.dart';
import 'package:demo_retrofit_api/screens/app/bottom_NavigationBar/bottom_navigation.dart';
import 'package:demo_retrofit_api/screens/app/homePage/home_page.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/add_work/add_work.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/level/level.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/level/task.dart/task.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/work.dart';
import 'package:demo_retrofit_api/screens/app/setting/profile/profile_info.dart';
import 'package:demo_retrofit_api/screens/authentication/login/login.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'auth/auth_loading.dart';
import 'screens/app/setting/setting.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddWorkLogic()),
        ChangeNotifierProvider(create: (_) => WorkLogic()),
        ChangeNotifierProvider(create: (_) => TaskLogic()),
        ChangeNotifierProvider(create: (_) => HomePageLogic()),
        ChangeNotifierProvider(create: (_) => ProfileLogic()),
        ChangeNotifierProvider(create: (_) => LevelLogic()),
        ChangeNotifierProvider(create: (_) => SettingLogic(context: _)),
        ChangeNotifierProvider(create: (_) => LoginLogic(context: _)),
      ],
      child: MaterialApp(
        home: AuthLoadingPage(),
        routes: {
          "/test": (context) {
            return AddWork();
          }
        },
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AutomaticKeepAliveClientMixin {
  late HomePageLogic logic;
  @override
  void initState() {
    super.initState();
    logic = context.read<HomePageLogic>();
  }

  List<Widget> page = const [
    MyHomePage(),
    Notifi(),
    Setting(),
  ];

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    logic;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          iconTheme: IconThemeData(color: AppColors.textBlueBlack),
          elevation: 0.0,
          leading: SizedBox(),
          title: Selector<HomePageLogic, String>(
            selector: (_, state) => state.title,
            builder: (_, value, __) {
              return Text(
                logic.title,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppColors.textBlueBlack,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      fontFamily: Assets.fonts.montserratBold,
                    ),
              );
            },
          ),
          centerTitle: true,
        ),
        body: Selector<HomePageLogic, Tuple2<int, PageController>>(
          selector: (_, state) => Tuple2(state.index, state.controller),
          builder: (_, value, __) {
            return PageView(
              children: page,
              controller: value.item2,
              onPageChanged: (index) {
                logic.changeIndex(index);
              },
            );
          },
        ),
        extendBody: true,
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
