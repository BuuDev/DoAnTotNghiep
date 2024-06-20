import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:doantotnghiep/Widgets/LabelCustom/label_textfield_custom.dart';
import 'package:flutter/material.dart';

class ContractWidget extends StatelessWidget {
  final int index;
  // final String contractCode;
  final String? nameEmployee;
  final String startDay;
  final String endDay;
  final String day;
  final int solangiahan;
  final Function()? giahan;
  final Function()? edit;
  final String? title;
  final bool? onEdit;
  final bool? hideButton;
  const ContractWidget({
    Key? key,
    required this.index,
    // required this.contractCode,
    required this.nameEmployee,
    required this.startDay,
    required this.endDay,
    required this.day,
    required this.solangiahan,
    this.giahan,
    this.edit,
    this.title,
    this.onEdit,
    this.hideButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(colors: [
          AppColors.textWhiteGray,
          Colors.white,
        ]),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     const LabelTextFieldCustom(
          //       value: 'Mã hợp đồng:',
          //       required: false,
          //     ),
          //     Text(
          //       contractCode,
          //       style: const TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.bold,
          //         fontFamily: 'Monserrat',
          //         color: AppColors.tertiary,
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const LabelTextFieldCustom(
                value: 'Họ tên:',
                required: false,
              ),
              Expanded(
                child: Text(
                  nameEmployee!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'Monserrat',
                    color: AppColors.acne3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const LabelTextFieldCustom(
                value: 'Ngày bắt đầu:',
                required: false,
              ),
              Text(
                Helper.formatDate(startDay),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Monserrat',
                  color: AppColors.acne3,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const LabelTextFieldCustom(
                value: 'Ngày kết thúc:',
                required: false,
              ),
              Text(
                Helper.formatDate(endDay),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Monserrat',
                  color: AppColors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const LabelTextFieldCustom(
                value: 'Ngày kí hợp đồng:',
                required: false,
              ),
              Text(
                Helper.formatDate(day),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Monserrat',
                  color: AppColors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const LabelTextFieldCustom(
                value: 'Số lần gia hạn:',
                required: false,
              ),
              Text(
                solangiahan.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Monserrat',
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          hideButton ?? false
              ? const SizedBox()
              : InkWell(
                  onTap: giahan,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                        child: Text(
                      title ?? 'Gia hạn hợp đồng',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.white,
                        // fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
          const SizedBox(
            height: 5,
          ),
          onEdit ?? false
              ? InkWell(
                  onTap: edit,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.colorCard,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                        child: Text(
                      title ?? 'Chỉnh sửa hợp đồng',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.white,
                        // fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                )
              : const SizedBox(),
          // InkWell(
          //   onTap: kethuc,
          //   child: Container(
          //     height: 40,
          //     decoration: const BoxDecoration(
          //       color: AppColors.red,
          //       borderRadius: BorderRadius.all(Radius.circular(5)),
          //     ),
          //     child: const Center(
          //         child: Text(
          //       'Kết thúc hợp đồng',
          //       style: TextStyle(
          //         fontSize: 13,
          //         color: AppColors.white,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     )),
          //   ),
          // ),
        ],
      ),
    );
  }
}
