import 'dart:io';

import 'package:demo_retrofit_api/models/work/work.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/add_work/add_work.dart';
import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/level/task.dart/task.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';

import 'searchWork/search_work.dart';
import 'work/work.dart';

// part 'work_home_page_logic.dart';

class WorkHomePage extends StatefulWidget {
  WorkHomePage({Key? key}) : super(key: key);

  @override
  State<WorkHomePage> createState() => _WorkHomePageState();
}

class _WorkHomePageState extends State<WorkHomePage> {
  late HomePageLogic workhomepageLogic;
  // late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    workhomepageLogic = context.read<HomePageLogic>();
    // animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();

    //animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: workhomepageLogic,
      child: Consumer<HomePageLogic>(builder: (_, logic, __) {
        return RefreshIndicator(
          onRefresh: () async {
            logic.refresh();
          },
          backgroundColor: AppColors.white,
          color: AppColors.textBlack,
          child: Scaffold(
            backgroundColor: AppColors.lightGray,
            body: SingleChildScrollView(
              padding:
                  EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 15),
                    child: Text(
                      "Tìm kiếm dự án đã tham gia",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 20,
                            color: AppColors.textBlueBlack,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  searchWord(context),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 15),
                    child: Text(
                      "Các dự án đã tham gia",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 20,
                            color: AppColors.textBlueBlack,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Selector<HomePageLogic, List<WorkModel>>(
                      selector: (_, state) => state.lstHienThi,
                      builder: (_, value, __) {
                        return value.isNotEmpty
                            ? GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.length + 1,
                                itemBuilder: ((context, index) {
                                  if (index == value.length) {
                                    return SizedBox(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AddWork(
                                                        id: null,
                                                      )));
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 70,
                                          color: AppColors.textTertiary,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                width: 3,
                                                color: AppColors.textTertiary),
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20))),
                                      ),
                                    );
                                  }
                                  return InkWell(
                                    onTap: (() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              Work(
                                                  id: value[index].id,
                                                  background: value[index]
                                                      .background
                                                      .toString()),
                                        ),
                                      );
                                      context.read<TaskLogic>().color = context
                                          .read<WorkLogic>()
                                          .backGroundWord(value[index]
                                              .background
                                              .toString());
                                    }),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(22)),
                                        color: AppColors.red,
                                        image: DecorationImage(
                                            image: logic.checkBackGround(
                                                    value[index]
                                                        .background
                                                        .toString())
                                                ? Image.asset(value[index]
                                                        .background
                                                        .toString())
                                                    .image
                                                : Image.file(File(value[index]
                                                        .background
                                                        .toString()))
                                                    .image,
                                            fit: BoxFit.fill),
                                      ),
                                      child: Center(
                                          child: Container(
                                        decoration: const BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        height: 25,
                                        width: 130,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Center(
                                              child: Text(
                                                value[index].name,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                      fontSize: 16,
                                                      color: AppColors
                                                          .textBlueBlack,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  );
                                }),
                              )
                            : SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.add,
                                    size: 70,
                                    color: AppColors.textTertiary,
                                  ),
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          width: 3,
                                          color: AppColors.textTertiary),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20))),
                                ),
                              );
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
