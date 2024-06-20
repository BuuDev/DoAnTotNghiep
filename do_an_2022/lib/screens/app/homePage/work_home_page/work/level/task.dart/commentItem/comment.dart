import 'package:flutter/material.dart';

import '../../../../../../../../gen/assets.gen.dart';
import '../../../../../../../../theme/color.dart';

Widget itemCommment(String lable, BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.lightBlue,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundImage: AssetImage(Assets.icon.avatar.path),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Title ",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 18,
                                    color: AppColors.textBlueBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                          children: [
                        TextSpan(
                          text: "fitledsf",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 17,
                                  color: AppColors.textBlueBlack,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.clip),
                        )
                      ])),
                  Card(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "subtitle",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 17,
                            color: AppColors.textBlueBlack,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.clip),
                      ),
                    ),
                  ),
                  Text(
                    "subtitle",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 15,
                          color: AppColors.gray,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_horiz,
              color: AppColors.textBlueBlack,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.emoji_people,
                      color: AppColors.textBlueBlack,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        "Thêm thành viên",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 18,
                              color: AppColors.textBlueBlack,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: AppColors.textBlueBlack,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        "Xóa",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 18,
                              color: AppColors.textBlueBlack,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
