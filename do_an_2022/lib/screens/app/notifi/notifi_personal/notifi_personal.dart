import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../../theme/color.dart';

class NotifiPersonal extends StatefulWidget {
  const NotifiPersonal({Key? key}) : super(key: key);

  @override
  State<NotifiPersonal> createState() => _NotifiPersonalState();
}

class _NotifiPersonalState extends State<NotifiPersonal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Divider(height: 1, color: AppColors.lightGray),
          );
        },
        // itemCount: value.data.length,
        itemBuilder: ((context, index) {
          // if (index == value.data.length) {
          //   return FooterLoading(isLoading: value.isLoading);
          // }
          // return statusItem(context, value.data[index]);
          return notifiItem(context);
        }),
        itemCount: 9,
      ),
    );
  }
}

Widget notifiItem(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Công việc của công ty vừa giao trong ngày hôm nay bạn đã sẵn sàng nhận công việc chưa nào",
                          maxLines: 3,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    height: 1.4,
                                    fontFamily: Assets.fonts.montserratSemiBold,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textBlueBlack,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Quản lý của bạn",
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            fontFamily: Assets.fonts.montserratSemiBold,
                            fontWeight: FontWeight.w600,
                            color: AppColors.silvergrey,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
