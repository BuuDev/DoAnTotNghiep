import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Widgets/EmployItem/employ_item.dart';
import 'package:doantotnghiep/Widgets/ItemFilterEmployee/item_filter_emloyee.dart';
import 'package:doantotnghiep/Widgets/TextFieldSearch/textfield_search.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'employee_management_logic.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeManagementScreen> createState() =>
      _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  late EmployeeManagementLogic employeeManagementLogic;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    employeeManagementLogic = EmployeeManagementLogic(context: context);
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        employeeManagementLogic.loadMore();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    employeeManagementLogic.dispose();
    super.dispose();
  }

  Map<String, dynamic> userDemo = {
    'name': 'Bùi Tuấn Anh',
    'birthday': '23 / 09 /2001',
    'phone': '0765829485',
    'cmnd': '301764309',
    'email': 'tuananhvip1099@gmail.com',
    'address': 'Long An',
    'username': 'tuananh2001',
    'phongban': 'Phòng IT',
    'chucvu': 'Nhân viên',
    'avatar':
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHBlb3BsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: employeeManagementLogic,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          title: const Text(
            'Quản lí nhân viên',
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
                  Navigator.pushNamed(context, Routes().addNewContract,
                          arguments: '')
                      .then((value) {
                    if (value == true) {
                      employeeManagementLogic.getListUser();
                    }
                  });
                },
                icon: const Icon(Icons.group_add_outlined,
                    color: AppColors.textBlack))
          ],
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextFieldSearch(
                placeholder: 'Tìm kiếm nhân viên',
                // readOnly: true,
                onChanged: (val) async {
                  employeeManagementLogic.searchUser(val);
                },
                onTap: () {
                  // Navigator.pushNamed(context, Routes().searchEmployee);
                },
              ),
            ),
            preferredSize: const Size.fromHeight(45),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            employeeManagementLogic.getListUser();
          },
          child: SingleChildScrollView(
            controller: controller,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Selector<EmployeeManagementLogic, int>(
                      selector: (_, state) => state.lst,
                      builder: (_, value, __) {
                        return const Text(
                          'Danh sách nhân viên',
                          style: TextStyle(
                            color: AppColors.acne3,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          showBottomSheetFilterEmployee(context, items: [
                            ItemFilterEmployee(
                              title: 'Sắp xếp theo tên từ A đến Z',
                              icon: Icons.move_down_rounded,
                              onTap: () {
                                employeeManagementLogic.sort();
                              },
                              color: AppColors.black,
                            ),
                          ]);
                          // employeeManagementLogic.sort();
                        },
                        child: const Text('Sắp xếp'))
                  ],
                ),
                //
                //
                Consumer<EmployeeManagementLogic>(
                  builder: (_, value, __) {
                    return employeeManagementLogic.lstUser.isEmpty
                        ? !employeeManagementLogic.load
                            ? Container(
                                color: AppColors.transparent,
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width / 3,
                                child: const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 2,
                                      child: Image.asset(
                                        Assets.images.empty.path,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text('Danh sách nhân viên trống'),
                                  ],
                                ),
                              )
                        : Column(
                            children: List.generate(value.lst, (index) {
                              return index == value.lst - 1 &&
                                      !value.isLoadMore &&
                                      value.lst < value.total
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 15),
                                      child: Center(
                                          child: CupertinoActivityIndicator()),
                                    )
                                  : EmployItem(
                                      email: value.lstUser[index].email!,
                                      avatar: value.lstUser[index].avatar,
                                      icon: Icons.more_vert_outlined,
                                      name: value.lstUser[index].fullname!,
                                      onTap: () {
                                        showBottomSheetFilterEmployee(
                                          context,
                                          height: 120,
                                          items: [
                                            ItemFilterEmployee(
                                              title: 'Thông tin nhân viên',
                                              icon: Icons.info_outlined,
                                              onTap: () {
                                                controller.animateTo(0,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    curve: Curves.linear);
                                                Navigator.pushNamed(context,
                                                        Routes().addNewEmployee,
                                                        arguments:
                                                            employeeManagementLogic
                                                                .lstUser[index])
                                                    .then(
                                                  (value) {
                                                    if (value == true) {
                                                      employeeManagementLogic
                                                          .getListUser();
                                                      Navigator.pop(context);
                                                    } else {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                );
                                              },
                                              color: AppColors.black,
                                            ),
                                            ItemFilterEmployee(
                                              title: 'Danh sách hợp đồng',
                                              icon: Icons
                                                  .format_list_bulleted_rounded,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                        context,
                                                        Routes()
                                                            .contractPersonal,
                                                        arguments:
                                                            employeeManagementLogic
                                                                .lstUser[index]
                                                                .id)
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              color: AppColors.black,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                            }),
                          );
                  },
                ),
                // if (lst >= 50 && isLoadMore == true)
                //   const Text(
                //     'No data',
                //     style: TextStyle(color: AppColors.red),
                //   )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheetFilterEmployee(BuildContext context,
      {double? height, List<Widget>? items}) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        builder: (_) {
          return Container(
            width: double.infinity,
            height: height ?? 70,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items ?? [],
            ),
          );
        });
  }
}
