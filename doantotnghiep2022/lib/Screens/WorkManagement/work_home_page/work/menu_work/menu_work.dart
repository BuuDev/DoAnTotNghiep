import 'package:doantotnghiep/Models/workManage/work/work.dart';
import 'package:doantotnghiep/Screens/WorkManagement/work_home_page/work/garbage_work/garbage_work.dart';
import 'package:doantotnghiep/Screens/WorkManagement/work_manage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../../../Config/Colors/colors.dart';
import '../../../../../Services/Helper/notify_helper.dart';
import '../../../../../Widgets/ActionDialog/action_dialog.dart';
import '../../../../../routes/routes.dart';
import '../../../../Account/account.dart';
import '../add_work/add_work.dart';
import '../work.dart';

class MenuWork extends StatefulWidget {
  final WorkModel model;
  const MenuWork({Key? key, required this.model}) : super(key: key);

  @override
  State<MenuWork> createState() => _MenuWorkState();
}

class _MenuWorkState extends State<MenuWork> {
  late WorkLogic workLogic;
  @override
  void initState() {
    workLogic = context.read<WorkLogic>();
    super.initState();
  }

  final List<Tuple2<String, IconData>> contents = [
    const Tuple2(
      "Chi Tiết",
      Icons.create,
    ),
    const Tuple2(
      "Lọc",
      Icons.filter_list,
    ),
    const Tuple2("Thùng rác", Icons.delete_sweep),
    const Tuple2(
      "Xóa",
      Icons.delete,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: workLogic,
      child: Consumer<WorkLogic>(builder: (_, logic, __) {
        return PopupMenuButton(
          icon: const Icon(Icons.more_horiz),
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
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            e.item1,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
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
              case "Chi Tiết":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //chưa
                    builder: (BuildContext context) => AddWork(
                      work: widget.model,
                      check: true,
                    ),
                  ),
                );
                break;
              case "Lọc":
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    backgroundColor: AppColors.lightGray,
                    title: Text(
                      "Trạng thái",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 22,
                            color: AppColors.textBlueBlack,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Selector<WorkLogic, bool>(
                              selector: (_, state) => state.checkHetHan,
                              builder: (_, check, __) {
                                return InkWell(
                                  onTap: (() {
                                    logic.hetHan();
                                  }),
                                  child: Card(
                                    color: check
                                        ? AppColors.primary
                                        : AppColors.white,
                                    child: SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Thẻ sắp hết hạn",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontSize: 16,
                                                color: check
                                                    ? AppColors.white
                                                    : AppColors.textBlueBlack,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          Selector<WorkLogic, bool>(
                              selector: (_, state) => state.checkSapHetHan,
                              builder: (_, check, __) {
                                return InkWell(
                                  onTap: (() {
                                    setState(() {
                                      logic.sapHetHan();
                                    });
                                  }),
                                  child: Card(
                                    color: check
                                        ? AppColors.primary
                                        : AppColors.white,
                                    child: SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Thẻ quá hạn",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontSize: 16,
                                                color: check
                                                    ? AppColors.white
                                                    : AppColors.textBlueBlack,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    actions: [
                      Selector<WorkLogic, Tuple2<bool, bool>>(
                          selector: (_, state) =>
                              Tuple2(state.checkHetHan, state.checkSapHetHan),
                          builder: (_, data, __) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: !data.item1 && !data.item2
                                    ? AppColors.grayBackground
                                    : AppColors.primary,
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                "Cập nhật",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 16,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            );
                          }),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            logic.setHienThi();
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          "Hủy lọc",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 16,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    ],
                  ),
                );
                break;
              case "Thùng rác":
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => GarbageWork(id_work: widget.model.id,),
                  ),
                );
                break;
              case "Xóa":
                if (context.read<AccountLogic>().user!.id ==
                    widget.model.userId) {
                  actionDialog(context, "Bạn có muốn xóa công việc này?",
                      icon: Icons.question_mark_outlined,
                      cancel: () {}, yes: () async {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes().viewStack, (route) => true);
                    await logic.deleteWork(widget.model.id);
                    context.read<WorkManagementLogic>().getData();
                  }).then((value) => Navigator.pop(context));
                } else {
                  NotifyHelper.showSnackBar(
                      "Bạn khoogn được thực hiện chức năng này");
                }
            }
          }),
        );
      }),
    );
  }
}
