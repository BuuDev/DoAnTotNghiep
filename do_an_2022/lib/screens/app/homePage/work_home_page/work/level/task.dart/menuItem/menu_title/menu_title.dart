import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../../../../theme/color.dart';

Widget MenuTitle() {
  final List<Tuple2<String, IconData>> contents = [
    Tuple2(
      "Chi tiết",
      Icons.create,
    ),
    Tuple2(
      "Lọc",
      Icons.filter_list,
    ),
    Tuple2(
      "Xóa",
      Icons.delete,
    ),
  ];
  return PopupMenuButton(
    icon: Icon(Icons.more_horiz),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    itemBuilder: (context) {
      return contents
          .map(
            (e) => PopupMenuItem(
              value: e.item1,
              child: Row(
                children: [
                  Icon(
                    e.item2,
                    color: AppColors.textBlueBlack,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      e.item1,
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
          )
          .toList();
    },
    onSelected: ((value) {
      switch (value) {
        case "Chi tiết":
          break;
        case "Lọc":
          break;
        case "Xóa":
          break;
      }
    }),
  );
}
