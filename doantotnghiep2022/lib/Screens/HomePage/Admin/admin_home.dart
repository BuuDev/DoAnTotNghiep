import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Contract/contract.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:doantotnghiep/Models/don_xin_nghi_phep/annual_leave.dart';
import 'package:doantotnghiep/Screens/dark_mode_provider.dart';
import 'package:doantotnghiep/Services/Api/AnnualLeave/annualLeave.dart';
import 'package:doantotnghiep/Services/Api/Contract/contract.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Widgets/ContractWidget/contract_widget.dart';
import 'package:doantotnghiep/Widgets/DonNghiPhepChoDuyetCustom/don_nghi_phep_cho_duyet_custom.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'admin_home_logic.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>
    with SingleTickerProviderStateMixin {
  late AdminHomeLogic adminHomeLogic;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    adminHomeLogic = AdminHomeLogic();
    // adminHomeLogic.initAnimation(this);
    // adminHomeLogic.activeAnimation();
    // controller.addListener(() {
    //   if (controller.position.pixels == controller.position.maxScrollExtent) {
    //     adminHomeLogic.loadMore();
    //   }
    // });
  }

  @override
  void dispose() {
    adminHomeLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: adminHomeLogic,
      child: RefreshIndicator(
        onRefresh: () async => adminHomeLogic.getListContractIsAboutToExpire(),
        child: Scaffold(
          backgroundColor: context.read<DarkModeProvider>().darkmode
              ? AppColors.gray
              : AppColors.white,
          body: SingleChildScrollView(
            controller: controller,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(
                    'Danh sách chức năng',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsserat",
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      adminHomeLogic.menu.length,
                      (index) => InkWell(
                        onTap: () {
                          adminHomeLogic.menu[index]['onTap'](context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: index == 0 ? 15 : 5,
                              right: index == 5 ? 15 : 5),
                          width: 150,
                          decoration: BoxDecoration(
                            color: adminHomeLogic.menu[index]
                                ['backgroundColor'],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, left: 10),
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  adminHomeLogic.menu[index]['icon'],
                                  color: AppColors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0)
                                    .copyWith(bottom: 20),
                                child: Text(
                                  adminHomeLogic.menu[index]['title']
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    fontFamily: "Monsserat",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15)
                      .copyWith(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hợp đồng sắp hết hạn',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Monsserat",
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes().contractManagement,
                                arguments: 1);
                          },
                          child: const Text(
                            'Tất cả',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Monsserat",
                            ),
                          )),
                    ],
                  ),
                ),
                Consumer<AdminHomeLogic>(
                  builder: (_, value, __) {
                    return value.lstContractIsAboutToExpire.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: List.generate(
                                value.lstContractIsAboutToExpire.length >= 3
                                    ? 3
                                    : value.lstContractIsAboutToExpire.length,
                                (index) => ContractWidget(
                                  nameEmployee: value
                                      .lstContractIsAboutToExpire[index]
                                      .user!
                                      .fullname,
                                  startDay: value
                                      .lstContractIsAboutToExpire[index]
                                      .startDate,
                                  endDay: value
                                      .lstContractIsAboutToExpire[index]
                                      .finishDate,
                                  day: value.lstContractIsAboutToExpire[index]
                                      .signingDate,
                                  index: index + 1,
                                  solangiahan: value
                                      .lstContractIsAboutToExpire[index].count,
                                  giahan: () {
                                    Navigator.pushNamed(context,
                                        Routes().addNewContractPersonal,
                                        arguments: [
                                          'giahan',
                                          value
                                              .lstContractIsAboutToExpire[index]
                                        ]).then((value) {
                                      if (value == true) {
                                        adminHomeLogic
                                            .getListContractIsAboutToExpire();
                                      }
                                    });
                                  },
                                  edit: () {},
                                ),
                              ),
                            ),
                          )
                        : !adminHomeLogic.load
                            ? Container(
                                color: AppColors.transparent,
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width / 3,
                                child: const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 2,
                                      child: Image.asset(
                                        Assets.images.empty.path,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text('Chưa có hợp đồng cần gia hạn'),
                                  ],
                                ),
                              );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(
                    top: 5,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Đơn nghỉ phép chờ duyệt',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Monsserat",
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes().applicationLeave);
                          },
                          child: const Text(
                            'Tất cả',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: "Monsserat",
                            ),
                          )),
                    ],
                  ),
                ),
                Consumer<AdminHomeLogic>(
                  builder: (_, value, __) {
                    return adminHomeLogic.lstAnnualWait.isNotEmpty
                        ? Column(
                            children: List.generate(
                                adminHomeLogic.lstAnnualWait.length >= 3
                                    ? 3
                                    : adminHomeLogic.lstAnnualWait.length,
                                (index) {
                            return AnnualLeaveWaiting(
                              avatar: adminHomeLogic
                                  .lstAnnualWait[index].user.avatar,
                              nameOfUser: adminHomeLogic
                                  .lstAnnualWait[index].user.fullname!,
                              startDay: adminHomeLogic
                                  .lstAnnualWait[index].start_date,
                              endDay: adminHomeLogic
                                  .lstAnnualWait[index].finish_date,
                              create: adminHomeLogic
                                  .lstAnnualWait[index].created_at,
                              reason:
                                  adminHomeLogic.lstAnnualWait[index].reason,
                              onSuccess: () {},
                              onCancel: () {},
                            );
                          }))
                        : !adminHomeLogic.load
                            ? Container(
                                color: AppColors.transparent,
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width / 3,
                                child: const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 2,
                                      child: Image.asset(
                                        Assets.images.empty.path,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                        'Chưa có đơn nghỉ phép chờ duyệt'),
                                  ],
                                ),
                              );
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
