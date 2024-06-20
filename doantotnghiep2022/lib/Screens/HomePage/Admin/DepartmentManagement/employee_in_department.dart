import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Widgets/EmployItem/employ_item.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'employee_in_department_logic.dart';

class EmployeeInDepartment extends StatefulWidget {
  const EmployeeInDepartment({Key? key}) : super(key: key);

  @override
  State<EmployeeInDepartment> createState() => _EmployeeInDepartmentState();
}

class _EmployeeInDepartmentState extends State<EmployeeInDepartment> {
  late EmployeeInDepartmentLogic employeeInDepartmentLogic;
  @override
  void initState() {
    super.initState();
    employeeInDepartmentLogic = EmployeeInDepartmentLogic(context: context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      int id = ModalRoute.of(context)!.settings.arguments as int;
      employeeInDepartmentLogic.getEployeeInDepartment(id);
    });
  }

  @override
  void dispose() {
    employeeInDepartmentLogic.dispose();
    super.dispose();
  }

  int get id => ModalRoute.of(context)!.settings.arguments as int;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: employeeInDepartmentLogic,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.transparent,
            elevation: 0.0,
            title: const Text(
              'Danh sách nhân viên',
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
            bottom: PreferredSize(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Selector<EmployeeInDepartmentLogic, String>(
                  selector: (_, state) => state.title,
                  builder: (_, value, __) {
                    return Text(
                      employeeInDepartmentLogic.title,
                      style: const TextStyle(
                        color: AppColors.acne3,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Monsserat',
                      ),
                    );
                  },
                ),
              ),
              preferredSize: const Size.fromHeight(30),
            )),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Consumer<EmployeeInDepartmentLogic>(
            builder: (_, value, __) {
              return employeeInDepartmentLogic.data.isEmpty
                  ? const SizedBox()
                  : Column(
                      children: List.generate(
                        employeeInDepartmentLogic.data.length,
                        (index) => EmployItem(
                          email: employeeInDepartmentLogic.data[index].email!,
                          avatar: employeeInDepartmentLogic.data[index].avatar,
                          name: employeeInDepartmentLogic.data[index].fullname,
                          isHideAction: true,
                          onTapListTile: () {
                            Navigator.pushNamed(
                                    context, Routes().addNewEmployee,
                                    arguments:
                                        employeeInDepartmentLogic.data[index])
                                .then((value) => employeeInDepartmentLogic
                                    .getEployeeInDepartment(id));
                          },
                          onTap: () {
                            Navigator.pushNamed(
                                    context, Routes().addNewEmployee,
                                    arguments:
                                        employeeInDepartmentLogic.data[index])
                                .then(
                              (value) {
                                if (value == true) {
                                  employeeInDepartmentLogic
                                      .getEployeeInDepartment(id);
                                }
                              },
                            );
                          },
                          onTap2: () {
                            Navigator.pushNamed(
                                context, Routes().contractPersonal,
                                arguments:
                                    employeeInDepartmentLogic.data[index].id);
                          },
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
