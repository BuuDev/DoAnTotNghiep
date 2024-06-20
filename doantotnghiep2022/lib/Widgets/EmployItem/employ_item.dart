import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class EmployItem extends StatelessWidget {
  final String? avatar;
  final String? name;
  final String email;
  final Function()? onTap;
  final Function()? onTap2;
  final Function()? onTapListTile;
  final bool? isHideAction;
  final IconData? icon;
  const EmployItem({
    this.avatar,
    this.name,
    required this.email,
    this.onTap,
    this.onTap2,
    this.onTapListTile,
    this.isHideAction,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 211, 210, 210),
            offset: Offset(0, -1),
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onTapListTile,
            contentPadding: const EdgeInsets.all(0),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff009688).withOpacity(0.7),
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: avatar == null
                    ? Image.asset(Assets.images.avatarNull.path)
                    : Image.network(
                        avatar ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Image.asset(Assets.images.avatarNull.path);
                        },
                      ),
              ),
            ),
            title: Text(
              name ?? '',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              email,
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 14, overflow: TextOverflow.ellipsis),
            ),
            trailing: isHideAction ?? false
                ? null
                : IconButton(
                    onPressed: onTap,
                    icon: Icon(
                      icon ?? Icons.unfold_more_rounded,
                    )),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10.0, left: 5, bottom: 15),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: InkWell(
          //           onTap: onTap,
          //           child: Container(
          //             width: 150,
          //             height: 40,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(5),
          //               color: AppColors.primary.withOpacity(0.8),
          //             ),
          //             child: const Center(
          //               child: Text(
          //                 'Thông tin chi tiết',
          //                 style: TextStyle(
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w700,
          //                   color: AppColors.white,
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
          //           onTap: onTap2,
          //           child: Container(
          //             width: 150,
          //             height: 40,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(5),
          //               color: AppColors.red.withOpacity(0.8),
          //             ),
          //             child: const Center(
          //               child: Text(
          //                 'Hợp đồng cá nhân',
          //                 style: TextStyle(
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w700,
          //                   color: AppColors.white,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
