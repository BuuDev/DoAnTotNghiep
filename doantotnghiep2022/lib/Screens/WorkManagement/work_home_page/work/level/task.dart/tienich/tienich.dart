import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../Config/Colors/colors.dart';

import '../task.dart';

class TienIch extends StatefulWidget {
  const TienIch({
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

  @override
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
                  trailing: const Icon(Icons.expand_less),
                  contentPadding: const EdgeInsets.all(8),
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
                                  onPressed: () {
                                    setState(() {
                                      logic.hidelistTask(context);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32)),
                                          ),
                                          child: const Icon(Icons.person)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Thêm danh sách công việc",
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
                            const SizedBox(
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
                                  onPressed: () async {
                                    logic.selectFile();
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            color: AppColors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32)),
                                          ),
                                          child: const Icon(Icons.publish)),
                                      const SizedBox(
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
                      const SizedBox(
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
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            color: AppColors.acne1,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32)),
                                          ),
                                          child: const Icon(Icons.image)),
                                      const SizedBox(
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
                            const SizedBox(
                              width: 15,
                            ),
                            const Expanded(
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
