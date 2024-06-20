import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/salary/salary_data.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'salary_detail_logic.dart';

class DetailSalary extends StatefulWidget {
  const DetailSalary({Key? key}) : super(key: key);

  @override
  State<DetailSalary> createState() => _DetailSalaryState();
}

class _DetailSalaryState extends State<DetailSalary> {
  late SalaryDetailLogic logic;
  @override
  void initState() {
    super.initState();
    logic = SalaryDetailLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    SalaryData infor = ModalRoute.of(context)!.settings.arguments as SalaryData;
    return ChangeNotifierProvider.value(
      value: logic,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.colorCard,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                infor.user!.fullname ?? '',
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: Assets.googleFonts.montserratBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
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
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Selector<SalaryDetailLogic, String>(
            selector: (p0, p1) => p1.name,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Thông tin cơ bản',
                        style: TextStyle(
                          fontFamily: Assets.googleFonts.montserratBlack,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InforCustom('Họ và tên: ', infor.user!.fullname),
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
                    InforCustom('Email: ', infor.user!.email),
                    driver(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mức lương',
                        style: TextStyle(
                          fontFamily: Assets.googleFonts.montserratBlack,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InforCustom('Số ngày công: ', infor.working_day.toString()),
                    driver(),
                    InforCustom(
                        'Mức lương cơ bản: ',
                        infor.contract == null
                            ? ''
                            : '${Helper.toMoney('${infor.contract!.salary ?? '0'}')}'
                                ' VNĐ'),
                    driver(),
                    InforCustom('Trợ cấp: ', '${infor.allowance ?? ''}' ' VNĐ'),
                    driver(),
                    InforCustom(
                        'Tổng lương: ',
                        '${Helper.toMoney(infor.tongLuong().toString())}'
                            ' VNĐ'),
                    driver(),
                    InforCustom(
                        'Lương tạm ứng: ', '${infor.advance ?? ''}' ' VNĐ'),
                    driver(),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Lương nhận được: ',
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
                              '${Helper.toMoney(infor.luong().toString())} VNĐ',
                              style: TextStyle(
                                  fontFamily:
                                      Assets.googleFonts.montserratBlack,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                    driver(),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class InforCustom extends StatefulWidget {
  final String? name;
  final String? value;

  const InforCustom(this.name, this.value, {Key? key}) : super(key: key);

  @override
  State<InforCustom> createState() => _InforCustomState();
}

Widget driver() {
  return Divider(
    height: 35,
    thickness: 2,
    color: AppColors.black.withOpacity(0.3),
  );
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
            color: AppColors.textBlack,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      Expanded(
        child: Text(
          widget.value!,
          style: TextStyle(
              fontFamily: Assets.googleFonts.montserratBlack,
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
      ),
    ]);
  }
}
