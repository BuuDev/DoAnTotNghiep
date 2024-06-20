import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Role/role.dart';
import 'package:doantotnghiep/Services/Api/Role/role.dart';
import 'package:doantotnghiep/Widgets/ActionDialog/action_dialog.dart';
import 'package:doantotnghiep/Widgets/TextFieldSearch/textfield_search.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'role_management_logic.dart';

class RoleManagement extends StatefulWidget {
  const RoleManagement({Key? key}) : super(key: key);

  @override
  State<RoleManagement> createState() => _RoleManagementState();
}

class _RoleManagementState extends State<RoleManagement> {
  late RoleManagementLogic roleManagementLogic;

  @override
  void initState() {
    super.initState();
    roleManagementLogic = RoleManagementLogic(context: context);
  }

  @override
  void dispose() {
    roleManagementLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: roleManagementLogic,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.transparent,
            elevation: 0.0,
            title: const Text(
              'Quản lí chức vụ',
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
                    Navigator.pushNamed(context, Routes().addRoles,
                        arguments: null);
                  },
                  icon: const Icon(Icons.person_add_alt_outlined,
                      color: AppColors.textBlack))
            ],
            bottom: const PreferredSize(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFieldSearch(
                  placeholder: 'Tìm kiếm chức vụ',
                ),
              ),
              preferredSize: Size.fromHeight(45),
            )),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Consumer<RoleManagementLogic>(
                        builder: (_, value, __) {
                          return const Text(
                            'Tên chức vụ (3)',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.acne3,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  TextButton(onPressed: () {}, child: const Text('Sắp xếp'))
                ],
              ),
              Consumer<RoleManagementLogic>(
                builder: (_, value, __) {
                  return Column(
                    children: List.generate(
                        roleManagementLogic.lst.length,
                        (index) => Container(
                              padding: const EdgeInsets.only(left: 15),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xff009688).withOpacity(0.7),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  roleManagementLogic.lst[index].name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {},
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, Routes().addRoles,
                                              arguments: roleManagementLogic
                                                  .lst[index]);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          actionDialog(
                                            context,
                                            'Bạn có thật sự muốn xoá chức vụ này?',
                                            icon: Icons.question_mark_outlined,
                                            cancel: () {},
                                            yes: () {},
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.close_outlined,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ),
                            )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
