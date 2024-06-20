import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Timekeep/time_keep_data.dart';
import 'package:doantotnghiep/Screens/TimekeepingTimekeeping/Timekeep_detail/timekeep_detail_info/timekeep_detail_checkin/timekeep_checkin.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'timekeep_detail_info/timekeep_detail_info/timekeep_info.dart';

class TimeKeepDetail extends StatefulWidget {
  const TimeKeepDetail({Key? key}) : super(key: key);

  @override
  State<TimeKeepDetail> createState() => _TimeKeepDetailState();
}

class _TimeKeepDetailState extends State<TimeKeepDetail>
    with AutomaticKeepAliveClientMixin {
  late CheckInLogic checkin;
  @override
  void initState() {
    super.initState();
    checkin = CheckInLogic();
    context.read<CheckInLogic>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    TimeKeepData infor =
        ModalRoute.of(context)!.settings.arguments as TimeKeepData;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //backgroundColor: AppColors.white,
        appBar: AppBar(
          shadowColor: AppColors.white.withOpacity(0),
          backgroundColor: AppColors.colorCard,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                infor.user!.fullname!,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontFamily: Assets.googleFonts.montserratBlack,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 45,
                height: 45,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(90)),
                  child: Image.network(
                    infor.user!.avatar ?? '',
                    fit: BoxFit.fill,
                    errorBuilder: (context, exception, stackTrace) {
                      return Image.asset(
                        Assets.images.avatarNull.path,
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
              size: 25,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              indicatorWeight: 3,
              indicatorColor: AppColors.black,
              labelPadding: const EdgeInsets.symmetric(vertical: 8),
              tabs: [
                Text(
                  'CHẤM CÔNG',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontFamily: Assets.googleFonts.montserratBlack,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'THÔNG TIN',
                  style: TextStyle(
                      color: AppColors.white,
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
            TimeKeepCheckIn(),
            TimeKeepInfo(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
