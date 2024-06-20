import 'dart:io';

import 'package:demo_retrofit_api/models/level/level.dart';
import 'package:demo_retrofit_api/models/level/level_item.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/level/task.dart/task.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/work.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task.dart/menuItem/menu_level/menu_level.dart';
part 'level_logic.dart';

class Level extends StatefulWidget {
  final int id;
  Level({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  late WorkLogic workLogic;
  late LevelLogic levelLogic;
  late LevelModel levelModel;
  int i = 0;
  static double width(BuildContext context) {
    double insets = MediaQuery.of(context).size.width;
    return insets;
  }

  bool checkAddWork = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    workLogic = context.read<WorkLogic>();
    levelLogic = context.read<LevelLogic>();
    for (int i = 0; i < workLogic.listLevel.length; i++) {
      if (workLogic.listLevel[i].id == widget.id) {
        levelModel = workLogic.listLevel[i];
      }
    }
  }

  Widget _Task(int id, String title) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Task(
              id: id,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 15,
                            color: AppColors.textBlueBlack,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: 30,
                          child: Card(
                            color: AppColors.red,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.access_time,
                                  color: AppColors.white,
                                  size: 14,
                                ),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  "7 thg 6",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontSize: 13,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ))),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          height: 30,
                          child: Card(
                            color: AppColors.green,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.check_box_outlined,
                                  color: AppColors.white,
                                  size: 14,
                                ),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  "4/4",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontSize: 13,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ))),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        SizedBox(
                          width: 120,
                          child: Stack(
                            children: List.generate(
                              4,
                              (index) => Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          (20 * (4 - (index + 1))).toDouble()),
                                  child: Material(
                                      borderRadius: BorderRadius.circular(36),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.asset(
                                        "assets/icon/avatar.png",
                                        width: 30,
                                        height: 30,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: levelLogic,
      child: Consumer<LevelLogic>(builder: (_, value, __) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Selector<WorkLogic, List<LevelItem>>(
                selector: (_, state) => state.listHienThi,
                builder: (_, lst, __) {
                  return Container(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: const BoxDecoration(
                      color: AppColors.textLightGrayBG,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    width: width(context) * 0.8,
                    height: lst[widget.id].listTask! == []
                        ? 150
                        : ((130 + (80 * lst[widget.id].listTask!.length))
                                    .toDouble() >
                                500
                            ? 500
                            : (130 + (80 * lst[widget.id].listTask!.length))
                                .toDouble()),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: lst[widget.id].listTask == [] ? 0 : 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  levelModel.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontSize: 18,
                                        color: AppColors.textBlueBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              MenuLevel(widget.id, context)
                            ],
                          ),
                        ),
                        lst[widget.id].listTask == []
                            ? SizedBox()
                            : Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: lst[widget.id].listTask!.length,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        _Task(
                                            lst[widget.id].listTask![index].id,
                                            lst[widget.id]
                                                .listTask![index]
                                                .title)),
                              ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: checkAddWork
                              ? Container(
                                  height: 80,
                                  color: AppColors.textLightGrayBG,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        child: InkWell(
                                          onTap: (() {
                                            showGeneralDialog(
                                              barrierDismissible: true,
                                              barrierLabel:
                                                  MaterialLocalizations.of(
                                                          context)
                                                      .modalBarrierDismissLabel,
                                              transitionDuration:
                                                  Duration(microseconds: 200),
                                              barrierColor: AppColors.tertiary,
                                              context: context,
                                              pageBuilder:
                                                  (BuildContext context,
                                                          Animation first,
                                                          Animation second) =>
                                                      Center(
                                                child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Scaffold(
                                                      appBar: AppBar(
                                                        leading: IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon:
                                                              Icon(Icons.close),
                                                        ),
                                                        title: Text(
                                                          "Đặt tên",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        22,
                                                                    color: AppColors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                        ),
                                                        actions: [
                                                          Selector<LevelLogic,
                                                                  int>(
                                                              selector: (_,
                                                                      state) =>
                                                                  state
                                                                      .checkMota,
                                                              builder: (_,
                                                                  counter, __) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(15),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      value.setString(value
                                                                          .controllerMoTa
                                                                          .text);
                                                                    },
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Xong",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .subtitle1!
                                                                            .copyWith(
                                                                              fontSize: 20,
                                                                              color: counter > 40 ? AppColors.gray.withOpacity(0.8) : AppColors.white,
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                        ],
                                                      ),
                                                      body: Container(
                                                        height: double.infinity,
                                                        child: Selector<
                                                                LevelLogic,
                                                                int>(
                                                            selector: (_,
                                                                    state) =>
                                                                state.checkMota,
                                                            builder: (_,
                                                                counter, __) {
                                                              return TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                controller: value
                                                                    .controllerMoTa,
                                                                onChanged:
                                                                    (text) {
                                                                  value.setString(value
                                                                      .controllerMoTa
                                                                      .text);
                                                                },
                                                                autofocus: true,
                                                                maxLines: null,
                                                                decoration:
                                                                    InputDecoration(
                                                                  helperText:
                                                                      "${counter}/40",
                                                                  helperStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle1!
                                                                      .copyWith(
                                                                        color: counter >
                                                                                40
                                                                            ? AppColors.red
                                                                            : AppColors.textLightGray,
                                                                      ),
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              15,
                                                                          right:
                                                                              15,
                                                                          top:
                                                                              30),
                                                                  hintText:
                                                                      "Nhập mô tả",
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle1!
                                                                      .copyWith(
                                                                        color: AppColors
                                                                            .textLightGray,
                                                                      ),
                                                                ),
                                                              );
                                                            }),
                                                      ),
                                                    )),
                                              ),
                                            ).then((e) => value.setString(
                                                value.controllerMoTa.text));
                                          }),
                                          child: Card(
                                            child: SizedBox(
                                              height: 40,
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  value.lableTask == []
                                                      ? "Thêm Tasks"
                                                      : value.lableTask,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                        fontSize: 16,
                                                        color: value.lableTask ==
                                                                    [] ||
                                                                value.lableTask ==
                                                                    "Thêm Tasks"
                                                            ? AppColors.gray
                                                                .withOpacity(
                                                                    0.7)
                                                            : AppColors
                                                                .textBlueBlack,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: InkWell(
                                                  onTap: (() {
                                                    setState(() {
                                                      value.checkMota = 0;
                                                      value.lableTask =
                                                          "Thêm Tasks";
                                                      value.controllerMoTa =
                                                          TextEditingController();
                                                      checkAddWork =
                                                          !checkAddWork;
                                                    });
                                                  }),
                                                  child: Text(
                                                    "Hủy",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                          color:
                                                              AppColors.primary,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (() {
                                                setState(() {
                                                  value.checkMota = 0;
                                                  value.lableTask =
                                                      "Thêm Tasks";
                                                  value.controllerMoTa =
                                                      TextEditingController();
                                                  checkAddWork = !checkAddWork;
                                                });
                                              }),
                                              child: Text(
                                                "Thêm",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                      fontSize: 18,
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              checkAddWork = !checkAddWork;
                                            });
                                          },
                                          child: Text(
                                            "+ Thêm",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  fontSize: 16,
                                                  color: AppColors.textTertiary,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (() {
                                        context
                                            .read<TaskLogic>()
                                            .getSingleImage();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                Task(
                                              id: null,
                                            ),
                                          ),
                                        );
                                      }),
                                      child: Icon(
                                        Icons.image_outlined,
                                        color: AppColors.textTertiary,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        );
      }),
    );
  }
}
