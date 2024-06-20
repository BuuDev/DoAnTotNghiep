import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/Account/account.dart';
import 'package:doantotnghiep/Screens/TimekeepingTimekeeping/Timekeep_detail/timekeep_detail_info/timekeep_detail_checkin/timekeep_checkin.dart';
import 'package:doantotnghiep/Screens/TimekeepingTimekeeping/Timekeep_detail/timekeep_detail_info/timekeep_detail_info/timekeep_info.dart';
import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/level/task.dart/task.dart';
import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/work.dart';
import 'package:doantotnghiep/Screens/dark_mode_provider.dart';
import 'package:doantotnghiep/injection.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Screens/WorkManagement/work_manage.dart';

void main() async {
  await configurationDependInjection();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AccountLogic()),
      ChangeNotifierProvider(create: (_) => DarkModeProvider()),
      ChangeNotifierProvider(create: (_) => CheckInLogic()),
      ChangeNotifierProvider(create: (_) => InForLogic()),
      ChangeNotifierProvider(create: (_) => WorkLogic()),
      ChangeNotifierProvider(create: (_) => TaskLogic(context: _)),
      ChangeNotifierProvider(create: (_) => WorkManagementLogic()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: context.watch<DarkModeProvider>().darkmode
          ? ThemeData(
              primarySwatch: Colors.grey,
              primaryColor: Colors.grey,
              brightness: Brightness.dark,
              backgroundColor: Colors.grey,
              dividerColor: Colors.black12,
              appBarTheme: const AppBarTheme(color: AppColors.backgroundColor),
              // textTheme: AppTextTheme(mode: ThemeMode.dark).buildTextTheme(),
            )
          : ThemeData(
              // textTheme: AppTextTheme(mode: ThemeMode.light).buildTextTheme(),
              ),
      title: 'DIDOTEK MANAGEMENT',
      routes: Routes().configRoute,
      navigatorKey: GetIt.instance.get<GlobalKey<NavigatorState>>(),
    );
  }
}
