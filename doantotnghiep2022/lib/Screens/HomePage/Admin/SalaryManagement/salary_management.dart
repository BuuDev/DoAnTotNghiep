import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/salary/salary_data.dart';
import 'package:doantotnghiep/Services/Api/Salary/salary_api.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';
part 'salary_management_logic.dart';

class SalaryManagement extends StatefulWidget {
  const SalaryManagement({Key? key}) : super(key: key);

  @override
  State<SalaryManagement> createState() => _SalaryManagementState();
}

class _SalaryManagementState extends State<SalaryManagement> {
  late SalaryManagementLogic logic;
  @override
  void initState() {
    super.initState();
    logic = SalaryManagementLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0.0,
          title: const Text(
            'Lương nhân viên',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textBlack,
                size: 20,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Selector<SalaryManagementLogic, String>(
                selector: (p0, p1) => p1.currentDateShow,
                builder: (context, value, child) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tháng: $value',
                            style: const TextStyle(
                              color: AppColors.acne3,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Hiện tại: ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                            style: const TextStyle(
                              color: AppColors.acne3,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  );
                },
              ),
              Selector<SalaryManagementLogic, Tuple2<bool, String>>(
                selector: (p0, p1) => Tuple2(p1.checkMonth, p1.currentDateShow),
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      if (value.item1) {
                        logic.selectDate(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(value.item2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      ),
                    ),
                  );
                },
              ),
              Selector<SalaryManagementLogic, Tuple2<List<SalaryData>, bool>>(
                selector: (p0, p1) => Tuple2(p1.data, p1.checkAnimation),
                builder: (context, value, child) {
                  if (!value.item2) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Text('Không có dữ liệu'),
                      ),
                    );
                  }

                  if (value.item1.isEmpty && value.item2) {
                    return Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Column(
                            children: List.generate(10, (index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  side: BorderSide(
                                    color: Colors.black.withOpacity(0.5),
                                    width: 0.5,
                                  ),
                                ),
                                elevation: 1,
                                color: AppColors.backgroundColor,
                                child: Shimmer.fromColors(
                                  baseColor: AppColors.white,
                                  highlightColor: AppColors.gray,
                                  period: const Duration(milliseconds: 2000),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.all(10),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.black.withOpacity(0.5),
                                          radius: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 10,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                height: 10,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 10),
                                      //   child: Container(
                                      //     height: 20,
                                      //     width: 60,
                                      //     decoration: BoxDecoration(
                                      //         color: AppColors.black
                                      //             .withOpacity(0.5),
                                      //         borderRadius:
                                      //             BorderRadius.circular(30)),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    );
                  }
                  return Expanded(
                    child: RefreshIndicator(
                      color: AppColors.textBlack,
                      onRefresh: () async {
                        return Future<void>.delayed(const Duration(seconds: 1),
                            () {
                          logic.loadData();
                        });
                      },
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Column(
                            children:
                                List.generate(value.item1.length, (index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes().salaryDetail,
                                      arguments: value.item1[index]);
                                },
                                child: Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    side: BorderSide(
                                      color: Colors.black.withOpacity(1),
                                      width: 0.5,
                                    ),
                                  ),
                                  elevation: 2,
                                  color: AppColors.white,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.all(10),
                                        width: 70,
                                        height: 70,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          child: Image.network(
                                            value.item1[index].user == null
                                                ? ''
                                                : value.item1[index].user!
                                                        .avatar ??
                                                    '',
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, exception,
                                                stackTrace) {
                                              return Image.asset(
                                                Assets.images.avatarNull.path,
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.fill,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                value.item1[index].user == null
                                                    ? ''
                                                    : value.item1[index].user!
                                                        .fullname!,
                                                style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                value.item1[index].user == null
                                                    ? ''
                                                    : 'Năm sinh: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(value.item1[index].user!.birthday!))}',
                                                style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(right: 10),
                                      //   child: ElevatedButton(
                                      //       style: ElevatedButton.styleFrom(
                                      //         primary: AppColors.primary,
                                      //       ),
                                      //       onPressed: () {
                                      //         Navigator.pushNamed(
                                      //             context, Routes().salaryDetail,
                                      //             arguments: value.item1[index]);
                                      //       },
                                      //       child: const Text(
                                      //         'Xem Lương',
                                      //         style: TextStyle(fontSize: 12),
                                      //       )),
                                      // )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        // body: SingleChildScrollView(
        //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   child: Column(
        //     children: [
        //       // Selector<SalaryManagementLogic, bool>(
        //       //   selector: (_, state) => state.isHideButtonSort,
        //       //   builder: (_, value, __) {
        //       //     return !value
        //       //         ? Row(
        //       //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       //             children: [
        //       //               const Text(
        //       //                 'Loại lương',
        //       //                 style: TextStyle(
        //       //                   color: AppColors.acne3,
        //       //                   fontSize: 15,
        //       //                   fontWeight: FontWeight.bold,
        //       //                 ),
        //       //               ),
        //       //               TextButton(
        //       //                   onPressed: () {
        //       //                     salaryManagementLogic.sort();
        //       //                   },
        //       //                   child: const Text('Sắp xếp'))
        //       //             ],
        //       //           )
        //       //         : const SizedBox(
        //       //             height: 5,
        //       //           );
        //       //   },
        //       // ),
        //       // Consumer<SalaryManagementLogic>(
        //       //   builder: (_, value, __) {
        //       //     return Column(
        //       //       children: List.generate(
        //       //         salaryManagementLogic.lst.length,
        //       //         (index) => Consumer<SalaryManagementLogic>(
        //       //           builder: (_, value, __) {
        //       //             return SalaryItem(
        //       //               title: salaryManagementLogic.lst[index]['title'],
        //       //               money: salaryManagementLogic.lst[index]['salary'],
        //       //               action: () {
        //       //                 salaryItemAction(
        //       //                     context,
        //       //                     salaryManagementLogic.lst[index]['id'],
        //       //                     salaryManagementLogic.lst[index]['title'],
        //       //                     salaryManagementLogic.lst[index]['salary']);
        //       //               },
        //       //             );
        //       //           },
        //       //         ),
        //       //       ),
        //       //     );
        //       //   },
        //       // ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  // Future<dynamic> addNewLoaiLuong(BuildContext context,
  //     {int? id, String? typeSalary = '', String? salary = ''}) {
  //   return showDialog(
  //       context: context,
  //       builder: (_) {
  //         return AlertDialog(
  //           title: Center(
  //             child: Padding(
  //               padding: const EdgeInsets.only(bottom: 10),
  //               child: Text(
  //                 typeSalary!.isEmpty ? 'Thêm Loại Lương' : 'Sửa Loại Lương',
  //                 style: const TextStyle(
  //                   fontSize: 15,
  //                   fontFamily: 'Monserrat',
  //                 ),
  //               ),
  //             ),
  //           ),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const LabelTextFieldCustom(value: 'Tên loại lương'),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               TextFieldCustom(
  //                 controller: salaryManagementLogic.txtTypeSalary
  //                   ..text = typeSalary,
  //                 onChanged: (val) {
  //                   salaryManagementLogic.updateTypeSalary(val);
  //                 },
  //                 placeholder: 'Nhập tên loại lương...',
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               const LabelTextFieldCustom(value: 'Mức lương cơ bản'),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               TextFieldCustom(
  //                 controller: salaryManagementLogic.txtSalary..text = salary!,
  //                 onChanged: (val) {
  //                   salaryManagementLogic.updateSalary(val);
  //                 },
  //                 placeholder: 'mức lương...',
  //               ),
  //             ],
  //           ),
  //           contentPadding: const EdgeInsets.all(10),
  //           actions: [
  //             Row(
  //               children: [
  //                 Expanded(
  //                     child: InkWell(
  //                   onTap: () {
  //                     Navigator.pop(context, false);
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10),
  //                       color: AppColors.red,
  //                     ),
  //                     child: const Center(
  //                       child: Text(
  //                         'Không',
  //                         style: TextStyle(
  //                           color: AppColors.white,
  //                           fontFamily: 'Monserrat',
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 Expanded(
  //                   child: InkWell(
  //                     onTap: () {
  //                       if (typeSalary.isEmpty && salary.isEmpty) {
  //                         salaryManagementLogic.addNew(
  //                             salaryManagementLogic.txtTypeSalary.text,
  //                             salaryManagementLogic.txtSalary.text);
  //                         Navigator.pop(context, true);
  //                       } else {
  //                         salaryManagementLogic.update(
  //                             id!,
  //                             salaryManagementLogic.txtTypeSalary.text,
  //                             salaryManagementLogic.txtSalary.text);
  //                         Navigator.pop(context, true);
  //                       }
  //                     },
  //                     child: Container(
  //                       height: 40,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         color: AppColors.primary,
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           typeSalary.isNotEmpty ? 'Lưu' : 'Thêm',
  //                           style: const TextStyle(
  //                             color: AppColors.white,
  //                             fontFamily: 'Monserrat',
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         );
  //       }).then((value) {
  //     if (typeSalary!.isNotEmpty) {
  //       Navigator.pop(context);
  //     }
  //   });
  // }

  // Future<dynamic> salaryItemAction(
  //     BuildContext context, int id, String typeSalary, String salary) {
  //   return showModalBottomSheet(
  //       backgroundColor: AppColors.transparent,
  //       context: context,
  //       builder: (_) {
  //         return Container(
  //           width: double.infinity,
  //           height: 120,
  //           decoration: const BoxDecoration(
  //               color: AppColors.backgroundColor,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(10),
  //                   topRight: Radius.circular(10))),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               ListTile(
  //                 leading: const Icon(
  //                   Icons.settings_outlined,
  //                   size: 30,
  //                   color: AppColors.textBlack,
  //                 ),
  //                 title: const Text(
  //                   'Sửa loại lương',
  //                   style: TextStyle(
  //                     color: AppColors.textBlack,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 onTap: () {
  //                   addNewLoaiLuong(context,
  //                       id: id, typeSalary: typeSalary, salary: salary);
  //                 },
  //               ),
  //               ListTile(
  //                 leading: const Icon(
  //                   Icons.remove_circle_outline_outlined,
  //                   size: 30,
  //                   color: AppColors.red,
  //                 ),
  //                 title: const Text(
  //                   'Xoá loại lương',
  //                   style: TextStyle(
  //                     color: AppColors.red,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 onTap: () {
  //                   actionDialog(
  //                       context, 'Bạn có thật sự muốn xoá loại này không?',
  //                       icon: Icons.question_mark_outlined, cancel: () {
  //                     Navigator.pop(context);
  //                   }, yes: () {
  //                     salaryManagementLogic.delete(id);
  //                     Navigator.pop(context);
  //                   }).then((value) => Navigator.pop(context));
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
