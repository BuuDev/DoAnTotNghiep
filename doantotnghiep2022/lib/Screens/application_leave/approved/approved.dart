import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/don_xin_nghi_phep/annual_leave.dart';
import 'package:doantotnghiep/Services/Api/AnnualLeave/annualLeave.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';

import '../../../routes/routes.dart';
part 'approved_logic.dart';

class ApplicationApproved extends StatefulWidget {
  const ApplicationApproved({Key? key}) : super(key: key);

  @override
  State<ApplicationApproved> createState() => _ApprovedState();
}

class _ApprovedState extends State<ApplicationApproved> {
  late ApprovedLogic applicationLogic;
  @override
  void initState() {
    super.initState();
    applicationLogic = ApprovedLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: applicationLogic,
      child: Consumer<ApprovedLogic>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Selector<ApprovedLogic, int>(
                    selector: (p0, p1) => p1.sum,
                    builder: (context, value, child) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Đơn nghỉ phép đã duyệt ($value)',
                                style: const TextStyle(
                                  color: AppColors.acne3,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  applicationLogic.sort();
                                },
                                child: const Text(
                                  'Sắp xếp',
                                  style: TextStyle(
                                    color: AppColors.acne3,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                      );
                    },
                  ),
                  Selector<ApprovedLogic, Tuple2<List<AnnualLeaveData>, bool>>(
                    selector: (p0, p1) => Tuple2(p1.data, p1.checkNull),
                    builder: (context, value, child) {
                      if (!value.item2) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 50),
                            child: Text('Không có dữ liệu'),
                          ),
                        );
                      }
                      if (value.item1.isEmpty && value.item2) {
                        return Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Column(
                                children: List.generate(8, (index) {
                                  return Card(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      side: BorderSide(
                                        color: Colors.black.withOpacity(0.5),
                                        width: 0.5,
                                      ),
                                    ),
                                    elevation: 1,
                                    color: AppColors.backgroundColor,
                                    child: Shimmer.fromColors(
                                      baseColor: AppColors.white,
                                      highlightColor: AppColors.gray,
                                      period:
                                          const Duration(milliseconds: 2000),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: CircleAvatar(
                                              backgroundColor: AppColors.black
                                                  .withOpacity(0.5),
                                              radius: 28,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.black
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Container(
                                                    height: 10,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.black
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Container(
                                                    height: 10,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.black
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              height: 10,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: AppColors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        );
                      }
                      return Expanded(
                        child: RefreshIndicator(
                          color: AppColors.textBlack,
                          onRefresh: () async {
                            return Future<void>.delayed(
                                const Duration(seconds: 1), () {
                              applicationLogic.loadData();
                            });
                          },
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Column(
                                children:
                                    List.generate(value.item1.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes().applicationDetail,
                                          arguments: value.item1[index]);
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        side: BorderSide(
                                          color: Colors.black.withOpacity(1),
                                          width: 0.5,
                                        ),
                                      ),
                                      elevation: 2,
                                      color: AppColors.white,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            width: 80,
                                            height: 80,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50)),
                                              child: Image.network(
                                                value.item1[index].user
                                                        .avatar ??
                                                    '',
                                                fit: BoxFit.fill,
                                                errorBuilder: (context,
                                                    exception, stackTrace) {
                                                  return Image.asset(
                                                    Assets
                                                        .images.avatarNull.path,
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.fill,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    value.item1[index].user
                                                        .fullname!,
                                                    style: const TextStyle(
                                                        color: AppColors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    'Ngày tạo: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(value.item1[index].created_at))}',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: AppColors.black,
                                                        fontFamily: Assets
                                                            .googleFonts
                                                            .montserratBoldItalic),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Chi tiết',
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontSize: 12,
                                                        color: AppColors.black,
                                                        fontFamily: Assets
                                                            .googleFonts
                                                            .montserratBoldItalic),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              const Icon(
                                                Icons.done,
                                                size: 20,
                                                color: Color.fromARGB(
                                                    255, 16, 79, 239),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  value.item1[index].status == 0
                                                      ? 'Chờ duyệt'
                                                      : 'Đã duyệt',
                                                  style: TextStyle(
                                                      color: value.item1[index]
                                                                  .status ==
                                                              1
                                                          ? const Color
                                                                  .fromARGB(
                                                              255, 16, 79, 239)
                                                          : AppColors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: Assets
                                                          .googleFonts
                                                          .montserratBold),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
