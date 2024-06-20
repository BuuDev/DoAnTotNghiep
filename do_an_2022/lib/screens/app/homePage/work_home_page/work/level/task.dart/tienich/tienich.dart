import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/level/task.dart/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../theme/color.dart';

class TienIch extends StatefulWidget {
  TienIch({
    Key? key,
  }) : super(key: key);

  @override
  State<TienIch> createState() => _TienIchState();
}

class _TienIchState extends State<TienIch> {
  late TaskLogic taskLogic;
  @override
  void initState() {
    taskLogic = context.read<TaskLogic>();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: taskLogic,
      child: Consumer<TaskLogic>(builder: (_, logic, __) {
        return Container(
          color: AppColors.white,
          height: logic.visible ? 210 : 75,
          child: Column(
            children: [
              InkWell(
                onTap: (() {
                  setState(() {
                    logic.visible = !logic.visible;
                  });
                }),
                child: ListTile(
                  title: Text(
                    "Các thao tác nhanh",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 15,
                          color: AppColors.textBlueBlack,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  trailing: Icon(Icons.expand_less),
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
              Visibility(
                visible: logic.visible,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.lightGray,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0.0,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32)),
                                          ),
                                          child: Icon(Icons.person)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Thành Viên",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontSize: 14,
                                                color: AppColors.textBlueBlack,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  )),
                            )),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.lightGray,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0.0,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            color: AppColors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32)),
                                          ),
                                          child: Icon(Icons.publish)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Thêm tệp đính kèm",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontSize: 14,
                                                color: AppColors.textBlueBlack,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  )),
                            )),
                          ]),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.lightGray,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0.0,
                                  ),
                                  onPressed: () {
                                    logic.getSingleImage();
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            color: AppColors.acne1,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32)),
                                          ),
                                          child: Icon(Icons.image)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Thêm Ảnh Mô Tả",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontSize: 14,
                                                color: AppColors.textBlueBlack,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  )),
                            )),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: SizedBox(
                              height: 50,
                            )),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
