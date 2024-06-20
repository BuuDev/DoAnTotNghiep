import 'package:doantotnghiep/Models/workManage/task/task_comment/task_comment.dart';
import 'package:flutter/material.dart';

import '../../../../../../../Config/Colors/colors.dart';
import '../menuItem/menu_comment/menu_comment.dart';

Widget itemCommment(TaskComment model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   height: 40,
        //   width: 40,
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: AppColors.lightBlue,
        //       width: 2,
        //     ),
        //     shape: BoxShape.circle,
        //   ),
        //   child: CircleAvatar(
        //     maxRadius: 25,
        //     backgroundImage: AssetImage(Assets.images.avatar.path),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // RichText(
              //     text: TextSpan(
              //         text: "Title ",
              //         style: Theme.of(context).textTheme.subtitle1!.copyWith(
              //               fontSize: 18,
              //               color: AppColors.textBlueBlack,
              //               fontWeight: FontWeight.bold,
              //             ),
              //         children: [
              //       TextSpan(
              //         text: "fitledsf",
              //         style: Theme.of(context).textTheme.subtitle1!.copyWith(
              //             fontSize: 17,
              //             color: AppColors.textBlueBlack,
              //             fontWeight: FontWeight.w400,
              //             overflow: TextOverflow.clip),
              //       )
              //     ])),
              Card(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      model.content,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 17,
                          color: AppColors.textBlueBlack,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.visible),
                    ),
                  ),
                ),
              ),
              Text(
                "${model.createdAt}",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 15,
                      color: AppColors.gray,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
        menuComment()
      ],
    ),
  );
}
