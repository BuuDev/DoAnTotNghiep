import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'salary_logic.dart';

class Salary extends StatefulWidget {
  const Salary({Key? key}) : super(key: key);

  @override
  State<Salary> createState() => _SalaryState();
}

class _SalaryState extends State<Salary> {
  late SalaryLogic logic;
  @override
  void initState() {
    super.initState();
    logic = SalaryLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: AppColors.white.withOpacity(0),
          backgroundColor: AppColors.backgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Xuan nguyen',
                style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 15,
                    fontFamily: Assets.googleFonts.montserratBlack,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 22),
                child: CircleAvatar(
                  backgroundColor: AppColors.purpleBlueBold,
                  radius: 20,
                ),
              ),
            ],
          ),
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textBlack,
              size: 25,
            ),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          logic.reduce();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.textBlack,
                          size: 25,
                        ),
                      ),
                      Selector<SalaryLogic, String>(
                        selector: (p0, p1) => p1.currentDateShow,
                        builder: (context, value, child) {
                          return Center(
                            child: Text(value,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          logic.add();
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.textBlack,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
