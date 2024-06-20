import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/dark_mode_provider.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemWork extends StatelessWidget {
  final Color? color;
  final String? title;
  final Function()? onTap;
  final IconData? iconSmall;
  final BoxFit? fit;
  const ItemWork({
    this.color,
    this.onTap,
    this.title,
    this.iconSmall,
    this.fit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          // padding: const EdgeInsets.only(left: 55),
          width: double.infinity,
          height: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
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
                fit: fit),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconSmall,
                  color: AppColors.backgroundColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(title!,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: AppColors.backgroundColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'Monserrat',
                          )),
                ),
              ],
            ),
          )),
    );
  }
}
