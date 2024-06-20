import 'dart:math';

import 'package:demo_retrofit_api/models/work/work.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work_home_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../theme/color.dart';
part 'home_page_logic.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late HomePageLogic homepageLogic;
  late TabController tabController;

  // late AnimationController animationController;
  int i = 3;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    homepageLogic = context.read<HomePageLogic>();

    // animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  // @override
  // void dispose() {
  //   super.dispose();

  //   //animationController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        FocusScope.of(context).unfocus();
      }),
      child: Scaffold(body: WorkHomePage()),
    );
  }
}
