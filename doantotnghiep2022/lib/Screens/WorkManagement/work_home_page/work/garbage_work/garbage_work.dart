import 'package:doantotnghiep/Models/workManage/task/task_item_model.dart';
import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/work.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../../Config/Colors/colors.dart';

class GarbageWork extends StatefulWidget {
  final int id_work;
  const GarbageWork({Key? key, required this.id_work}) : super(key: key);

  @override
  State<GarbageWork> createState() => _GarbageWorkState();
}

class _GarbageWorkState extends State<GarbageWork> {
  late WorkLogic workLogic;

  @override
  void initState() {
    workLogic = WorkLogic();
    workLogic.getGarbage(widget.id_work);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: workLogic,
      child: Consumer<WorkLogic>(builder: (_, logic, __) {
        return Scaffold(
            backgroundColor: AppColors.textLightGrayBG,
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              leading: InkWell(
                  onTap: (() {
                    Navigator.pop(context);
                  }),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  )),
              title: const Text(
                "Thùng Rác",
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            body: SingleChildScrollView(
              child: Selector<WorkLogic, List<TaskItemModel>>(
                  selector: ((_, state) => state.lstGarbage),
                  builder: (_, lst, __) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Danh sách các nhiệm vụ đã xóa",
                            style: TextStyle(
                                color: AppColors.textBlueBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8, bottom: 8),
                          child: Text(
                            "(Sau 30 ngày sẽ bị xóa vĩnh viễn)",
                            style: TextStyle(
                                color: AppColors.textBlueBlack,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: lst.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    width: double.infinity,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      lst[index].title!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                            fontSize: 15,
                                                            color: AppColors
                                                                .textBlueBlack,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Icon(
                                                              Icons.delete))),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  if (lst[index].timeOut !=
                                                      null)
                                                    SizedBox(
                                                      width: 110,
                                                      height: 30,
                                                      child: Card(
                                                        color: AppColors.red,
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Icon(
                                                              Icons.access_time,
                                                              color: AppColors
                                                                  .white,
                                                              size: 14,
                                                            ),
                                                            Expanded(
                                                                child: Center(
                                                                    child: Text(
                                                              "${DateFormat('dd-MM-yyyy hh:mm:ss').parse(lst[index].deletedAt!).day} tháng ${DateFormat('dd-MM-yyyy hh:mm:ss').parse(lst[index].deletedAt!).month}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    color: AppColors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ))),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  // if (logic.lstTaskDetail.isNotEmpty)
                                                  //   SizedBox(
                                                  //     height: 30,
                                                  //     width: 60,
                                                  //     child: Card(
                                                  //       color: logic.counterStatus() == 0
                                                  //           ? AppColors.red
                                                  //           : (logic.counterStatus() ==
                                                  //                   logic.lstTaskDetail.length)
                                                  //               ? AppColors.green
                                                  //               : AppColors.yellow,
                                                  //       child: Row(
                                                  //         children: [
                                                  //           const SizedBox(
                                                  //             width: 5,
                                                  //           ),
                                                  //           const Icon(
                                                  //             Icons.check_box_outlined,
                                                  //             color: AppColors.white,
                                                  //             size: 14,
                                                  //           ),
                                                  //           Expanded(
                                                  //               child: Center(
                                                  //                   child: Text(
                                                  //             "${logic.counterStatus()}/${logic.lstTaskDetail.length}",
                                                  //             style: Theme.of(context)
                                                  //                 .textTheme
                                                  //                 .subtitle1!
                                                  //                 .copyWith(
                                                  //                   fontSize: 13,
                                                  //                   color: AppColors.white,
                                                  //                   fontWeight: FontWeight.w500,
                                                  //                   overflow: TextOverflow.ellipsis,
                                                  //                 ),
                                                  //           ))),
                                                  //           const SizedBox(
                                                  //             width: 5,
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  //   Selector<TaskLogic, List<UserDemo>>(
                                                  //       selector: (_, state) => state.lstAssign,
                                                  //       builder: (_, lst, __) {
                                                  //         return Expanded(
                                                  //           child: Align(
                                                  //               alignment: Alignment.centerRight,
                                                  //               child: Row(
                                                  //                 mainAxisSize: MainAxisSize.min,
                                                  //                 children: List.generate(
                                                  //                     lst.length > 3 ? 3 : lst.length,
                                                  //                     (index) {
                                                  //                   if (lst.length > 3 && index == 2) {
                                                  //                     return Padding(
                                                  //                       padding:
                                                  //                           const EdgeInsets.all(1.0),
                                                  //                       child: Stack(
                                                  //                         children: [
                                                  //                           Material(
                                                  //                             borderRadius:
                                                  //                                 BorderRadius.circular(
                                                  //                                     36),
                                                  //                             clipBehavior: Clip
                                                  //                                 .antiAliasWithSaveLayer,
                                                  //                             child: Image.network(
                                                  //                                 lst[index].avatar ??
                                                  //                                     "",
                                                  //                                 width: 35,
                                                  //                                 height: 35,
                                                  //                                 fit: BoxFit.cover,
                                                  //                                 errorBuilder:
                                                  //                                     (_, __, ___) {
                                                  //                               return Image.asset(
                                                  //                                 Assets.images
                                                  //                                     .avatarNull.path,
                                                  //                                 width: 35,
                                                  //                                 height: 35,
                                                  //                               );
                                                  //                             }),
                                                  //                           ),
                                                  //                           Opacity(
                                                  //                             opacity: 0.6,
                                                  //                             child: SizedBox(
                                                  //                               width: 35,
                                                  //                               height: 35,
                                                  //                               child: Material(
                                                  //                                   borderRadius:
                                                  //                                       BorderRadius
                                                  //                                           .circular(
                                                  //                                               36),
                                                  //                                   clipBehavior: Clip
                                                  //                                       .antiAliasWithSaveLayer,
                                                  //                                   child: Center(
                                                  //                                     child: Text(
                                                  //                                         "+ ${lst.length - index}"),
                                                  //                                   )),
                                                  //                             ),
                                                  //                           ),
                                                  //                         ],
                                                  //                       ),
                                                  //                     );
                                                  //                   }
                                                  //                   return Padding(
                                                  //                     padding:
                                                  //                         const EdgeInsets.all(1.0),
                                                  //                     child: Material(
                                                  //                       borderRadius:
                                                  //                           BorderRadius.circular(36),
                                                  //                       clipBehavior:
                                                  //                           Clip.antiAliasWithSaveLayer,
                                                  //                       child: Image.network(
                                                  //                           lst[index].avatar ?? "",
                                                  //                           width: 35,
                                                  //                           height: 35,
                                                  //                           fit: BoxFit.cover,
                                                  //                           errorBuilder: (_, __, ___) {
                                                  //                         return Image.asset(
                                                  //                           Assets
                                                  //                               .images.avatarNull.path,
                                                  //                           width: 35,
                                                  //                           height: 35,
                                                  //                         );
                                                  //                       }),
                                                  //                     ),
                                                  //                   );
                                                  //                 }),
                                                  //               )),
                                                  //         );
                                                  //       }),
                                                  const Expanded(
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Icon(Icons
                                                              .undo_outlined))),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            }))
                      ],
                    );
                  }),
            ));
      }),
    );
  }
}
