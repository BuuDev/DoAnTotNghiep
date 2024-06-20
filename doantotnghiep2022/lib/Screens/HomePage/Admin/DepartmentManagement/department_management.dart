import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Department/department.dart';
import 'package:doantotnghiep/Services/Api/Department.dart/department.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/ActionDialog/action_dialog.dart';
import 'package:doantotnghiep/Widgets/DepartmentItem/department_item.dart';
import 'package:doantotnghiep/Widgets/LabelCustom/label_textfield_custom.dart';
import 'package:doantotnghiep/Widgets/TextFieldSearch/textfield_search.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'department_management_logic.dart';

class DepartmentManagementSceen extends StatefulWidget {
  const DepartmentManagementSceen({Key? key}) : super(key: key);

  @override
  State<DepartmentManagementSceen> createState() =>
      _DepartmentManagementSceenState();
}

class _DepartmentManagementSceenState extends State<DepartmentManagementSceen> {
  late DepartmentManagementLogic departmentManagementLogic;
  @override
  void initState() {
    super.initState();
    departmentManagementLogic = DepartmentManagementLogic(context: context);
  }

  @override
  void dispose() {
    departmentManagementLogic.dispose();
    super.dispose();
  }

  List lst = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: departmentManagementLogic,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.transparent,
            elevation: 0.0,
            title: const Text(
              'Quản lí phòng ban',
              style: TextStyle(
                color: AppColors.textBlack,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textBlack,
                  size: 15,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    addNewPhongBan(context);
                  },
                  icon: const Icon(Icons.domain_add_sharp,
                      color: AppColors.textBlack))
            ],
            bottom: PreferredSize(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFieldSearch(
                  placeholder: 'Tìm kiếm phòng ban',
                  onChanged: (val) {
                    departmentManagementLogic.search(val);
                  },
                ),
              ),
              preferredSize: const Size.fromHeight(45),
            )),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Consumer<DepartmentManagementLogic>(
                  builder: (_, value, __) {
                    return !value.isHideButtonSort
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${departmentManagementLogic.lstPhongban.length} Phòng ban',
                                style: const TextStyle(
                                  color: AppColors.acne3,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                  onPressed: departmentManagementLogic.sort,
                                  child: const Text('Sắp xếp'))
                            ],
                          )
                        : const SizedBox();
                  },
                ),
                Consumer<DepartmentManagementLogic>(
                  builder: (_, value, __) {
                    return Column(
                      children: List.generate(
                        departmentManagementLogic.lstPhongban.length,
                        (index) => DepartmentItem(
                          title:
                              departmentManagementLogic.lstPhongban[index].name,
                          onTap: () {
                            departmentItemAction(
                              context,
                              id: departmentManagementLogic
                                  .lstPhongban[index].id,
                              content: departmentManagementLogic
                                  .lstPhongban[index].name,
                            );
                          },
                          onTap2: () {
                            Navigator.pushNamed(
                                context, Routes().employeeInDepartment,
                                arguments: departmentManagementLogic
                                    .lstPhongban[index].id);
                          },
                        ),
                      ).reversed.toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> addNewPhongBan(BuildContext context,
      {int? id, String? content = ''}) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  content!.isEmpty ? 'Thêm Phòng Ban' : 'Sửa Phòng Ban',
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Monserrat',
                  ),
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelTextFieldCustom(value: 'Tên phòng ban'),
                const SizedBox(
                  height: 10,
                ),
                TextFieldCustom(
                  controller: departmentManagementLogic.txtAddNewPhongban
                    ..text = content,
                  placeholder: 'Nhập tên phòng ban...',
                  onChanged: (val) {
                    departmentManagementLogic.updateTxtAddNewPhongBan(val);
                  },
                ),
              ],
            ),
            contentPadding: const EdgeInsets.all(5),
            actions: [
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.red,
                      ),
                      child: const Center(
                        child: Text(
                          'Huỷ',
                          style: TextStyle(
                            color: AppColors.white,
                            fontFamily: 'Monserrat',
                          ),
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (content.isEmpty) {
                          departmentManagementLogic.addNew();
                        } else {
                          departmentManagementLogic.update(id!,
                              departmentManagementLogic.txtAddNewPhongban.text);
                        }
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primary,
                        ),
                        child: Center(
                          child: Text(
                            content.isNotEmpty ? 'Lưu' : 'Thêm',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontFamily: 'Monserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  Future<dynamic> departmentItemAction(BuildContext context,
      {int? id, String? content}) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        builder: (_) {
          return Container(
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                    size: 30,
                    color: AppColors.textBlack,
                  ),
                  title: const Text(
                    'Sửa phòng ban',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    addNewPhongBan(context, id: id, content: content)
                        .then((value) => Navigator.pop(context));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.remove_circle_outline_outlined,
                    size: 30,
                    color: AppColors.red,
                  ),
                  title: const Text(
                    'Xoá phòng ban',
                    style: TextStyle(
                      color: AppColors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    actionDialog(
                        context, 'Bạn có thật sự muốn xoá phòng ban này không?',
                        icon: Icons.question_mark_outlined, cancel: () {
                      Navigator.pop(context);
                    }, yes: () {
                      departmentManagementLogic.delete(id!);
                      Navigator.pop(context);
                    }).then((value) => Navigator.pop(context));
                  },
                ),
              ],
            ),
          );
        });
  }
}
