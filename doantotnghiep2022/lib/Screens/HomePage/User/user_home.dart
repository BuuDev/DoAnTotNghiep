import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/UserItem/user_item.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Config/Colors/colors.dart';

part 'user_home_logic.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  late UserHomeLogic userHomeLogic;
  @override
  void initState() {
    super.initState();
    userHomeLogic = UserHomeLogic();
    userHomeLogic.initAnimation(this);
    userHomeLogic.activeAnimation();
    Future.delayed(const Duration(seconds: 2), () {}).then((value) {
      userHomeLogic.checkIn(context);
    });
  }

  @override
  void dispose() {
    userHomeLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userHomeLogic,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Consumer<UserHomeLogic>(
                builder: (_, value, __) {
                  return userHomeLogic.lst
                      ? CustomUserItemLoading(
                          colors: [
                            userHomeLogic.baseColor.value!,
                            userHomeLogic.hightlightColor.value!
                          ],
                        )
                      : AnimatedOpacity(
                          opacity: userHomeLogic.opacity,
                          duration: const Duration(milliseconds: 500),
                          child: UserItem(
                            title: 'Viết đơn nghỉ phép',
                            icon: Icons.contact_mail_outlined,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes().vietXinNghiPhep);
                            },
                          ),
                        );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<UserHomeLogic>(
                builder: (_, value, __) {
                  return userHomeLogic.lst
                      ? CustomUserItemLoading(
                          colors: [
                            userHomeLogic.baseColor.value!,
                            userHomeLogic.hightlightColor.value!
                          ],
                        )
                      : AnimatedOpacity(
                          opacity: userHomeLogic.opacity,
                          duration: const Duration(milliseconds: 500),
                          child: UserItem(
                            title: 'Thu nhập cá nhân',
                            icon: Icons.attach_money_outlined,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes().salaryPersonal);
                            },
                          ),
                        );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<UserHomeLogic>(
                builder: (_, value, __) {
                  return userHomeLogic.lst
                      ? CustomUserItemLoading(
                          colors: [
                            userHomeLogic.baseColor.value!,
                            userHomeLogic.hightlightColor.value!
                          ],
                        )
                      : userHomeLogic.oncheckOut
                          ? const SizedBox()
                          : AnimatedOpacity(
                              opacity: userHomeLogic.opacity,
                              duration: const Duration(milliseconds: 500),
                              child: UserItem(
                                title: userHomeLogic.oncheckIn
                                    ? 'Check Out'
                                    : 'Check In',
                                icon: userHomeLogic.oncheckIn
                                    ? Icons.output_rounded
                                    : Icons.how_to_reg_outlined,
                                onTap: () {
                                  if (!userHomeLogic.oncheckIn) {
                                    userHomeLogic.checkIn(context);
                                  } else {
                                    userHomeLogic.checkOut(context);
                                  }
                                },
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

class CustomUserItemLoading extends StatelessWidget {
  final List<Color> colors;
  final double? width;
  const CustomUserItemLoading({
    required this.colors,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(colors: colors).createShader(rect);
        },
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        Colors.grey.shade100,
                        Colors.grey.shade100,
                      ])),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: width ?? 200,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade100,
                          Colors.grey.shade100,
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
