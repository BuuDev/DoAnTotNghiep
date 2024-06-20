import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Timekeep/time_keep_data.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
part 'timekeep_detail_info_logic.dart';

class TimeKeepInfo extends StatefulWidget {
  const TimeKeepInfo({Key? key}) : super(key: key);

  @override
  State<TimeKeepInfo> createState() => _TimeKeepInfoState();
}

class _TimeKeepInfoState extends State<TimeKeepInfo>
    with AutomaticKeepAliveClientMixin {
  late InForLogic inFor;

  @override
  void initState() {
    super.initState();
    inFor = InForLogic();
    context.read<InForLogic>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    TimeKeepData infor =
        ModalRoute.of(context)!.settings.arguments as TimeKeepData;
    return ChangeNotifierProvider.value(
      value: inFor,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Selector<InForLogic, String>(
            selector: (p0, p1) => p1.a,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    InforCustom('Họ và tên: ', infor.user!.fullname ?? ''),
                    driver(),
                    InforCustom(
                        'Ngày sinh: ',
                        DateFormat('dd-MM-yyyy')
                            .format(DateTime.parse(infor.user!.birthday!))),
                    driver(),
                    InforCustom('Số điện thoại: ', infor.user!.phone),
                    driver(),
                    InforCustom('Địa chỉ: ', infor.user!.address),
                    driver(),
                    InforCustom(
                        'CMND/CCCD:  ', infor.user!.citizenIdentification),
                    driver(),
                    InforCustom('Email: ', infor.user!.email),
                    driver(),
                    // const InforCustom('Chức vụ: ', 'Nhân viên'),
                    // driver(),
                    // const InforCustom('Phòng ban: ', 'Nhân sự'),
                    // driver()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget driver() {
  return Divider(
    height: 35,
    thickness: 2,
    color: AppColors.gray.withOpacity(0.2),
  );
}

class InforCustom extends StatefulWidget {
  final String? name;
  final String? value;

  const InforCustom(this.name, this.value, {Key? key}) : super(key: key);

  @override
  State<InforCustom> createState() => _InforCustomState();
}

class _InforCustomState extends State<InforCustom> {
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Text(
          widget.name!,
          style: TextStyle(
            fontFamily: Assets.googleFonts.montserratBlack,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      Expanded(
        child: Text(
          widget.value!,
          style: TextStyle(
              fontFamily: Assets.googleFonts.montserratBlack,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
    ]);
  }
}
