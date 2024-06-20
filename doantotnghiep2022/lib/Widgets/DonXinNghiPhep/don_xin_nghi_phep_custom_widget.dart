import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/dark_mode_provider.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/ActionItemEmployee/action_item_employee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DonXinNghiPhep extends StatelessWidget {
  final int id;
  final String name;
  final String startDay;
  final String endDay;
  final String lido;
  final String status;
  final int totalDay;
  final String? lidoHuy;
  final Function()? edit;
  final Function()? delete;
  const DonXinNghiPhep({
    required this.id,
    required this.name,
    required this.startDay,
    required this.endDay,
    required this.lido,
    this.lidoHuy,
    required this.status,
    required this.totalDay,
    this.edit,
    this.delete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          // borderRadius: BorderRadius.circular(15),
          border: Border(
            left: BorderSide(
              color: status == 'đã duyệt'
                  ? AppColors.green
                  : status == 'đang chờ duyệt'
                      ? AppColors.primary
                      : AppColors.red,
              width: 5,
            ),
          ),
          boxShadow: [
            BoxShadow(
                color: context.watch<DarkModeProvider>().darkmode
                    ? AppColors.white
                    : AppColors.gray,
                blurRadius: 10,
                offset: const Offset(1, 1)),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat("EEEE", 'vi').format(DateTime.parse(endDay)),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserrat',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat("dd/MM", 'vi').format(DateTime.parse(endDay)),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserrat',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '$totalDay Ngày',
                      style: const TextStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Monserrat',
                        color: AppColors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: status == 'đã duyệt'
                          ? AppColors.green
                          : status == 'đang chờ duyệt'
                              ? AppColors.primary
                              : AppColors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 1,
              color: AppColors.gray,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Đơn xin nghỉ phép',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monserrat',
                            color: AppColors.acne3,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        InkWell(
                            onTap: () {
                              if (status != 'đã duyệt') {
                                showModalBottomSheet(
                                    backgroundColor: AppColors.transparent,
                                    context: context,
                                    builder: (_) {
                                      return Container(
                                        width: double.infinity,
                                        height: 120,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: const BoxDecoration(
                                            color: AppColors.backgroundColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ActionItemEmployee(
                                              title: 'Chỉnh sửa đơn nghỉ phép',
                                              icon: Icons.info_outline_rounded,
                                              color: AppColors.textBlack,
                                              onTap: edit,
                                            ),
                                            ActionItemEmployee(
                                              title: 'Xoá đơn nghỉ phép',
                                              icon: Icons.remove_circle_outline,
                                              color: AppColors.red,
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        titlePadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        title: const Text(
                                                          'Bạn có thật sự muốn xoá đơn nghỉ phép này?',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Monserrat',
                                                          ),
                                                        ),
                                                        actions: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: AppColors
                                                                          .red,
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        'Không',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.white,
                                                                          fontFamily:
                                                                              'Monserrat',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: delete,
                                                                  child:
                                                                      Container(
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: AppColors
                                                                          .primary,
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        'Đồng ý',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.white,
                                                                          fontFamily:
                                                                              'Monserrat',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                NotifyHelper.showSnackBar(
                                    'Đơn đã duyệt,bạn không được phép chỉnh sửa!');
                              }
                            },
                            child: const Icon((Icons.more_horiz_sharp))),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Monserrat',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${DateFormat("EEEE dd/MM/yyyy", 'vi').format(DateTime.parse(startDay))} - ${DateFormat("EEEE dd/MM/yyyy", 'vi').format(DateTime.parse(endDay))}',
                      style: const TextStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                        color: AppColors.red,
                        fontFamily: 'Monserrat',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Lí do: $lido',
                      style: const TextStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Monserrat',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        status,
                        style: const TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'Monserrat',
                          color: AppColors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: status == 'đã duyệt'
                            ? AppColors.green
                            : status == 'đang chờ duyệt'
                                ? AppColors.primary
                                : AppColors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
