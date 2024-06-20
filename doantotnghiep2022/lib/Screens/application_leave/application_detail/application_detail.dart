import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/don_xin_nghi_phep/annual_leave.dart';
import 'package:doantotnghiep/Screens/application_leave/application_leave.dart';
import 'package:doantotnghiep/Services/Api/AnnualLeave/annualLeave.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'application_detail_logic.dart';

class ApplicationDetail extends StatefulWidget {
  const ApplicationDetail({Key? key}) : super(key: key);

  @override
  State<ApplicationDetail> createState() => _ApplicationDetailState();
}

class _ApplicationDetailState extends State<ApplicationDetail>
    with AutomaticKeepAliveClientMixin {
  late DetailLogic detail;
  @override
  void initState() {
    super.initState();
    detail = DetailLogic(context: context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      //detail.getdataDetail(0);
    });
  }

  AnnualLeaveData get id =>
      ModalRoute.of(context)!.settings.arguments as AnnualLeaveData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
        value: detail,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.colorCard,
            elevation: 0.0,
            title: const Text(
              'Chi tiết đơn nghỉ phép',
              style: TextStyle(
                color: AppColors.white,
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
                  color: AppColors.white,
                  size: 25,
                )),
            // actions: [
            //   IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.group_add_outlined,
            //           color: AppColors.textBlack))
            // ],
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // padding: const EdgeInsets.all(30),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Image.network(
                      id.user.avatar ?? '',
                      fit: BoxFit.fill,
                      errorBuilder: (context, exception, stackTrace) {
                        return Image.asset(
                          Assets.images.avatarNull.path,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  child: Text(
                    'Ảnh đại diện',
                    style: TextStyle(
                      fontFamily: Assets.googleFonts.montserratBlack,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInFor('Họ tên nhân viên: ', id.user.fullname),
                driver(),
                CustomInFor('Nghỉ từ ngày: ', id.start_date),
                driver(),
                CustomInFor('Nghỉ đến ngày: ', id.finish_date),
                driver(),
                CustomInFor('Số ngày nghỉ: ', id.total_day.toString()),
                driver(),
                CustomInFor('Lý do nghỉ phép: ', id.reason ?? ''),
                driver(),
                if (id.reason_not_approving != null) ...[
                  CustomInFor(
                      'Lý do không duyệt: ', id.reason_not_approving ?? ''),
                  driver(),
                ],
                if (id.status == 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10)),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                        title: const Icon(
                                          Icons.open_in_browser,
                                          size: 40,
                                          color: AppColors.red,
                                        ),
                                        content: const Text(
                                          "Bạn có muốn duyệt đơn này không?",
                                          style: TextStyle(
                                            color: AppColors.textBlack,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        actionsPadding: EdgeInsets.zero,
                                        actions: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Hủy'),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(AppColors
                                                                  .red)),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    detail.updateApprove(id.id);
                                                  },
                                                  child: const Text('Đồng ý'),
                                                ),
                                              ),
                                            ],
                                          )
                                        ]);
                                  });
                            },
                            child: const Text(
                              'Xác nhận',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10)),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Icon(
                                        Icons.delete,
                                        size: 35,
                                        color: AppColors.red,
                                      ),
                                      content: SizedBox(
                                        width: 100,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Vui lòng nhập lý do(*bắt buộc)",
                                              style: TextStyle(
                                                color: AppColors.textBlack,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: detail.controller,
                                              keyboardType: TextInputType.text,
                                              onChanged: (text) {
                                                detail.check();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actionsPadding: EdgeInsets.zero,
                                      actions: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  detail.clear();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Hủy'),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                                AppColors.red)),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: AppColors.primary,
                                                ),
                                                onPressed: () {
                                                  if (detail.checkEmpty) {
                                                    detail.disApp(id.id,
                                                        detail.controller.text);
                                                  }
                                                },
                                                child: const Text('Đồng ý'),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: const Text(
                              'Không duyệt',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  )
                ]
              ],
            ),
          )),
        ));
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

class CustomInFor extends StatefulWidget {
  final String? name;
  final String? value;

  const CustomInFor(this.name, this.value, {Key? key}) : super(key: key);

  @override
  State<CustomInFor> createState() => _InforCustomState();
}

class _InforCustomState extends State<CustomInFor> {
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Text(
          widget.name!,
          style: TextStyle(
            fontFamily: Assets.googleFonts.montserratBlack,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      Expanded(
        child: Text(
          widget.value!,
          style: TextStyle(
              fontFamily: Assets.googleFonts.montserratBlack,
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
      ),
    ]);
  }
}
