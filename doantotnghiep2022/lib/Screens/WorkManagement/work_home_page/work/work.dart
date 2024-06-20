import 'package:doantotnghiep/Models/workManage/task/task_item_model.dart';
import 'package:doantotnghiep/Models/workManage/work/work.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Config/Colors/colors.dart';
import '../../../../Models/workManage/level/level_demo.dart';
import '../../../../Models/workManage/task/task_model.dart';
import '../../../../Models/workManage/userwork/user_work.dart';
import '../../../../Services/Api/WordManage/work/work.dart';
import '../../../../Services/Helper/notify_helper.dart';
import 'add_level/add_level.dart';
import 'level/level.dart';
import 'menu_work/menu_work.dart';

part 'work_logic.dart';

class Work extends StatefulWidget {
  final WorkModel model;
  const Work({Key? key, required this.model}) : super(key: key);

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  late WorkLogic workLogic;

  //late PageController controller;

  @override
  void initState() {
    workLogic = context.read<WorkLogic>();
    workLogic.getListTask(widget.model.id);
    workLogic.lstSearchUser = widget.model.ds_user;
    workLogic.lstUserSearchHienThi = widget.model.ds_user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: workLogic,
      child: Consumer<WorkLogic>(builder: (_, logic, __) {
        return RefreshIndicator(
          color: AppColors.textBlack,
          onRefresh: () async {
            logic.getListTask(widget.model.id);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.model.name!),
              backgroundColor: AppColors.primary,
              actions: [MenuWork(model: widget.model)],
            ),
            backgroundColor: AppColors.primary.withOpacity(0.9),
            body: Selector<WorkLogic, List<TaskModelDemo>>(
                selector: ((_, state) => state.listHienThi!),
                builder: (_, lst, __) {
                  return Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: PageView.builder(
                            controller: workLogic.controller,
                            itemCount: lst.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              return index == lst.length
                                  ? AddLevel(
                                      id_work: widget.model.id,
                                      id_level: null,
                                    )
                                  : Level(
                                      taskItemModel: lst[index],
                                    );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: SmoothPageIndicator(
                          controller: workLogic.controller,
                          count: lst.length + 1,
                          effect: const ExpandingDotsEffect(
                              expansionFactor: 2,
                              dotColor: AppColors.textLightGray,
                              activeDotColor: AppColors.white),
                        ),
                      )
                    ],
                  );
                }),
          ),
        );
      }),
    );
  }
}
