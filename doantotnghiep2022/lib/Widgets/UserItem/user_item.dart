import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/dark_mode_provider.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function()? onTap;
  final List<Color>? colors;
  const UserItem({
    required this.title,
    this.icon,
    this.onTap,
    this.colors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: context.watch<DarkModeProvider>().darkmode
                      ? AppColors.white
                      : AppColors.gray,
                  blurRadius: 10,
                  offset: const Offset(1, 1)),
            ],
            image: DecorationImage(
                image: AssetImage(context.watch<DarkModeProvider>().darkmode
                    ? Assets.images.bg2.path
                    : Assets.images.bg1.path),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.backgroundColor,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(title,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: AppColors.backgroundColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Monserrat',
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
