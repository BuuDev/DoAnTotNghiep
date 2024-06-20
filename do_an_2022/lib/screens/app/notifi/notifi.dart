import 'package:demo_retrofit_api/screens/app/notifi/notifi_all/notifi_all.dart';
import 'package:demo_retrofit_api/screens/app/notifi/notifi_personal/notifi_personal.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:flutter/material.dart';

class Notifi extends StatefulWidget {
  const Notifi({Key? key}) : super(key: key);

  @override
  State<Notifi> createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: AppColors.textBlack,
            tabs: [
              Tab(
                child: Text(
                  "Tất cả",
                  style: TextStyle(color: AppColors.textBlack),
                ),
              ),
              Tab(
                child: Text(
                  "Cá nhân",
                  style: TextStyle(color: AppColors.textBlack),
                ),
              )
            ],
          ),
          body: TabBarView(children: [NotifiAll(), NotifiPersonal()]),
        ),
      ),
    );
  }
}
