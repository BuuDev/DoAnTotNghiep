import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/application_leave/approved/approved.dart';
import 'package:doantotnghiep/Screens/application_leave/delete/delete_approved.dart';
import 'package:doantotnghiep/Screens/application_leave/pending/pending.dart';
import 'package:doantotnghiep/Services/Api/AnnualLeave/annualLeave.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'applicatione_leave_logic.dart';

class ApplicationLeave extends StatefulWidget {
  const ApplicationLeave({Key? key}) : super(key: key);

  @override
  State<ApplicationLeave> createState() => _ApplicationLeaveState();
}

class _ApplicationLeaveState extends State<ApplicationLeave> {
  late ApplicationLogic logic;
  @override
  void initState() {
    super.initState();
    logic = ApplicationLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Consumer<ApplicationLogic>(
        builder: (context, value, child) {
          return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.backgroundColor,
                  elevation: 0.0,
                  title: const Text(
                    'Đơn xin nghỉ phép',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.textBlack,
                        size: 18,
                      )),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      indicatorWeight: 3,
                      indicatorColor: AppColors.black,
                      labelPadding: const EdgeInsets.symmetric(vertical: 8),
                      onTap: (index) {
                        logic.check(index);
                      },
                      tabs: [
                        Text(
                          'Đơn chờ duyệt',
                          style: TextStyle(
                              color:
                                  logic.a ? AppColors.primary : AppColors.gray,
                              fontSize: 15,
                              fontFamily: Assets.googleFonts.montserratBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Đơn đã duyệt',
                          style: TextStyle(
                              color:
                                  logic.b ? AppColors.primary : AppColors.gray,
                              fontSize: 15,
                              fontFamily: Assets.googleFonts.montserratBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Đơn không duyệt',
                          style: TextStyle(
                              color:
                                  logic.c ? AppColors.primary : AppColors.gray,
                              fontSize: 15,
                              fontFamily: Assets.googleFonts.montserratBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                body: const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    PenDing(),
                    ApplicationApproved(),
                    DisApprove(),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
