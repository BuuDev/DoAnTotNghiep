import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/salary/salary_data.dart';
import 'package:doantotnghiep/Services/Api/Salary/salary_api.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
part 'salary_personal_logic.dart';

class SalaryPersonal extends StatefulWidget {
  const SalaryPersonal({Key? key}) : super(key: key);

  @override
  State<SalaryPersonal> createState() => _SalaryPersonalState();
}

Widget spacerDivider() {
  return Divider(
    height: 35,
    thickness: 2,
    color: AppColors.gray.withOpacity(0.2),
  );
}

class _SalaryPersonalState extends State<SalaryPersonal> {
  late SalaryPersonalLogic salaryPersonalLogic;
  @override
  void initState() {
    super.initState();
    salaryPersonalLogic = SalaryPersonalLogic();
  }

  @override
  void dispose() {
    salaryPersonalLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: salaryPersonalLogic,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0.0,
          title: const Text(
            'Thu nhập cá nhân',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textBlack,
                size: 15,
              )),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Consumer<SalaryPersonalLogic>(
                builder: (_, value, __) {
                  return Container(
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        // color: AppColors.acneGreen,
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          AppColors.acneGreen,
                          AppColors.greenLight,
                        ])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            salaryPersonalLogic.data.isNotEmpty
                                ? salaryPersonalLogic.data[0].user!.fullname!
                                : '',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: "Monsserat",
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 10, bottom: 5),
                          child: Text(
                            'Thực lãnh',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Monsserat",
                            ),
                          ),
                        ),
                        salaryPersonalLogic.data.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 10),
                                child: Text(
                                  Helper.toMoney(((int.parse(salaryPersonalLogic
                                                  .data[0].actual_salary!) ~/
                                              22)
                                          .toString())) +
                                      'đ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Monsserat",
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            : !salaryPersonalLogic.load
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: CupertinoActivityIndicator(),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text('...'),
                                  ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                showMonthPicker(
                                        context: context,
                                        initialDate: DateTime.now())
                                    .then((value) {
                                  if (value != null) {
                                    salaryPersonalLogic.changeTime(value);
                                  }
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 10, bottom: 5),
                                    child: Text(
                                      'Lương tháng',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Monsserat",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          DateFormat('MM/yyyy')
                                              .format(salaryPersonalLogic.time),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Monsserat",
                                          ),
                                        ),
                                        const Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.attach_money_sharp,
                                size: 30,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Consumer<SalaryPersonalLogic>(
                builder: (_, value, __) {
                  return value.data.isNotEmpty
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            UserInfoItem(
                              title: 'Họ Tên',
                              value:
                                  salaryPersonalLogic.data[0].user!.fullname ??
                                      '',
                            ),
                            UserInfoItem(
                              title: 'Mức lương cơ bản',
                              value: salaryPersonalLogic.data.isNotEmpty
                                  ? Helper.toMoney(salaryPersonalLogic
                                          .data[0].contract!.salary
                                          .toString()) +
                                      'đ'
                                  : '',
                            ),
                            UserInfoItem(
                              title: 'Số ngày công',
                              value: salaryPersonalLogic.data[0].working_day
                                  .toString(),
                            ),
                            UserInfoItem(
                              title: 'Phụ cấp',
                              value:
                                  salaryPersonalLogic.data[0].allowance ?? '',
                            ),
                            UserInfoItem(
                              title: 'Lương thực nhận',
                              value: salaryPersonalLogic.data.isNotEmpty
                                  ? Helper.toMoney((int.parse(
                                                  salaryPersonalLogic.data[0]
                                                      .actual_salary!) ~/
                                              22)
                                          .toString()) +
                                      'đ'
                                  : '',
                            ),
                          ],
                        )
                      : !salaryPersonalLogic.load
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
                                  const Text('Không tìm thấy dữ liệu'),
                                ],
                              ),
                            );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoItem extends StatelessWidget {
  final String title;
  final String value;
  const UserInfoItem({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 211, 210, 210),
              offset: Offset(0, -1),
              blurRadius: 5,
            ),
          ],
        ),
        height: 55,
        child: Row(
          children: [
            Text(
              '$title:\t',
              style: const TextStyle(
                color: AppColors.textBlack,
                fontSize: 15,
                fontFamily: 'Monsserat',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textBlack,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
