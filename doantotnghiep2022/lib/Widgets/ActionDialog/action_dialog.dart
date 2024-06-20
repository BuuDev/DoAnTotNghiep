import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:flutter/material.dart';

Future<dynamic> actionDialog(BuildContext context, String title,
    {IconData? icon, Function()? cancel, Function()? yes}) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text(
            title,
            style: const TextStyle(
              color: AppColors.textBlack,
              fontSize: 15,
              fontFamily: 'Monserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: cancel,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.red,
                      ),
                      child: const Center(
                        child: Text(
                          'Không',
                          style: TextStyle(
                            color: AppColors.white,
                            fontFamily: 'Monserrat',
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
                    onTap: yes,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary,
                      ),
                      child: const Center(
                        child: Text(
                          'Đồng ý',
                          style: TextStyle(
                            color: AppColors.white,
                            fontFamily: 'Monserrat',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      });
}
