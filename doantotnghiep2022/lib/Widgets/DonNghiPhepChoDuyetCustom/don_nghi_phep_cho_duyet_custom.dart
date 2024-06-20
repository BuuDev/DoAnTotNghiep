import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AnnualLeaveWaiting extends StatelessWidget {
  String nameOfUser;
  String? avatar;
  String? startDay;
  String? endDay;
  String? reason;
  String? create;
  Function()? onSuccess;
  Function()? onCancel;
  AnnualLeaveWaiting({
    this.avatar,
    this.endDay,
    required this.nameOfUser,
    this.reason,
    this.startDay,
    this.create,
    this.onCancel,
    this.onSuccess,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.black, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 211, 210, 210),
            offset: Offset(0, -1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.green,
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.network(
                        avatar ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Image.asset(Assets.images.avatarNull.path);
                        },
                      )),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        nameOfUser,
                        style: const TextStyle(
                            fontFamily: "Monsserat",
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, bottom: 10, top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Ngày tạo đơn:',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' ${Helper.formatDate(create)}',
                            style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                // const SizedBox(
                //   width: 5,
                // ),
                // const Icon(
                //   Icons.person_outline_rounded,
                //   color: AppColors.textBlack,
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              bottom: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Nghỉ từ ngày: ',
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  Helper.formatDate(startDay),
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Đến ngày: ',
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  Helper.formatDate(endDay),
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Lý do: ',
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  reason ?? '',
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Theme(
          //   data: ThemeData(
          //     dividerColor: AppColors.transparent,
          //   ),
          //   child: ExpansionTile(
          //     childrenPadding: const EdgeInsets.symmetric(horizontal: 20)
          //         .copyWith(bottom: 10),
          //     title: const LabelTextFieldCustom(
          //       value: 'Lí do',
          //       required: false,
          //     ),
          //     children: [Text(reason ?? '')],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 10,
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: InkWell(
          //           onTap: onSuccess,
          //           child: Container(
          //             height: 40,
          //             decoration: BoxDecoration(
          //               color: AppColors.primary,
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             child: const Center(
          //               child: Text(
          //                 'Duyệt đơn',
          //                 style: TextStyle(
          //                   color: AppColors.white,
          //                   fontSize: 13,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       Expanded(
          //         child: InkWell(
          //           onTap: onCancel,
          //           child: Container(
          //             height: 40,
          //             decoration: BoxDecoration(
          //               color: AppColors.acneRed,
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             child: const Center(
          //               child: Text(
          //                 'Không duyệt đơn',
          //                 style: TextStyle(
          //                   color: AppColors.white,
          //                   fontSize: 13,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
