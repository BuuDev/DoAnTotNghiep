import 'package:doantotnghiep/Services/Api/WordManage/work/work.dart';
import 'package:doantotnghiep/Widgets/WorkItem/work_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Config/Colors/colors.dart';
import '../../Models/workManage/work/work.dart';
import '../HomePage/Admin/admin_home.dart';
import '../dark_mode_provider.dart';
import 'work_home_page/searchWork/search_work.dart';
import 'work_home_page/work/add_work/add_work.dart';
import 'work_home_page/work/work.dart';

part 'work_manage_logic.dart';

class WorkManagement extends StatefulWidget {
  const WorkManagement({Key? key}) : super(key: key);

  @override
  State<WorkManagement> createState() => _WorkManagementState();
}

class _WorkManagementState extends State<WorkManagement>
    with SingleTickerProviderStateMixin {
  late WorkManagementLogic homepageLogic;
  late AdminHomeLogic adminHomeLogic;
  int i = 3;
  @override
  void initState() {
    super.initState();
    adminHomeLogic = AdminHomeLogic();
    adminHomeLogic.initAnimation(this);
    adminHomeLogic.activeAnimation();
    homepageLogic = context.read<WorkManagementLogic>();
    homepageLogic.activeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        FocusScope.of(context).unfocus();
      }),
      child: ChangeNotifierProvider.value(
        value: homepageLogic,
        child: Consumer<WorkManagementLogic>(builder: (_, logic, __) {
          return RefreshIndicator(
            color: AppColors.textBlack,
            onRefresh: () async {
              logic.getData();
            },
            child: Scaffold(
              backgroundColor: context.watch<DarkModeProvider>().darkmode
                  ? Colors.grey
                  : null,
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
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
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child: Text(
                        "Các dự án đã tham gia",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 20,
                              color: AppColors.textBlueBlack,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    Selector<WorkManagementLogic, List<WorkModel>>(
                        selector: (_, state) => state.lstHienThi!,
                        builder: (_, value, __) {
                          return value.isNotEmpty
                              ? GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 150,
                                    childAspectRatio: 3 / 2,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.length + 1,
                                  itemBuilder: ((context, index) {
                                    if (index == 0) {
                                      return SizedBox(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AddWork(
                                                          work: null,
                                                          check: false,
                                                        ))).then((value) {
                                              logic.getData();
                                            });
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            size: 70,
                                            color: AppColors.textTertiary,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  width: 3,
                                                  color:
                                                      AppColors.textTertiary),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        ),
                                      );
                                    }
                                    return
                                        // adminHomeLogic.hide
                                        //     ? CustomUserItemLoading(
                                        //         colors: [
                                        //           adminHomeLogic.baseColor.value!,
                                        //           adminHomeLogic
                                        //               .hightlightColor.value!
                                        //         ],
                                        //       )
                                        //     :
                                        AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity: adminHomeLogic.opacity,
                                      child: ItemWork(
                                        iconSmall: Icons.work_outline,
                                        fit: BoxFit.cover,
                                        title: value[index - 1].name,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  Work(
                                                model: value[index - 1],
                                              ),
                                            ),
                                          ).then((value) {
                                            context
                                                .read<WorkLogic>()
                                                .returnWork();
                                          });
                                        },
                                      ),
                                    );
                                  }),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: 150,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddWork(
                                                    work: null,
                                                    check: false,
                                                  ))).then((value) {
                                        logic.getData();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      size: 70,
                                      color: AppColors.textTertiary,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 3,
                                            color: AppColors.textTertiary),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                );
                        }),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
