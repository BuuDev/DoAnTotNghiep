import 'dart:io';
import 'dart:math';

import 'package:demo_retrofit_api/models/level/level.dart';
import 'package:demo_retrofit_api/models/level/level_item.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../models/task/task_model.dart';
import 'add_level/add_level.dart';
import 'level/level.dart';
import 'menu_work/menu_work.dart';

part 'work_logic.dart';

class Work extends StatefulWidget {
  final int id;
  final String background;
  Work({Key? key, required this.background, required this.id})
      : super(key: key);

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  late WorkLogic workLogic;

  //late PageController controller;

  @override
  void initState() {
    workLogic = context.read<WorkLogic>();
    workLogic.setListTaskLevel();
    workLogic.listHienThi = workLogic.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: workLogic,
      child: Consumer<WorkLogic>(builder: (_, value, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Title"),
            backgroundColor: value.backGroundWord(widget.background),
            actions: [MenuWork(id: widget.id)],
          ),
          backgroundColor:
              value.backGroundWord(widget.background).withOpacity(0.9),
          body: Stack(
            children: [
              value.backGroundWord(widget.background) == AppColors.gray
                  ? Image.file(
                      File(widget.background),
                      fit: BoxFit.cover,
                    )
                  : SizedBox(),
              Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: PageView.builder(
                        controller: workLogic.controller,
                        itemCount: workLogic.listPageLevel.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index == workLogic.listPageLevel.length
                              ? AddLevel()
                              : workLogic.listPageLevel[index];
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: SmoothPageIndicator(
                      controller: workLogic.controller,
                      count: workLogic.listPageLevel.length + 1,
                      effect: ExpandingDotsEffect(
                          expansionFactor: 2,
                          dotColor: AppColors.textLightGray,
                          activeDotColor: AppColors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
