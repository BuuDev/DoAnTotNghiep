import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Role/permission.dart';
import 'package:doantotnghiep/Models/Role/role.dart';
import 'package:doantotnghiep/Services/Api/Role/role.dart';
import 'package:doantotnghiep/Widgets/LabelCustom/label_textfield_custom.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'add_new_role_logic.dart';

class AddNewRole extends StatefulWidget {
  const AddNewRole({Key? key}) : super(key: key);

  @override
  State<AddNewRole> createState() => _AddNewRoleState();
}

class _AddNewRoleState extends State<AddNewRole> {
  late AddNewRoleLogic addNewRoleLogic;

  @override
  void initState() {
    super.initState();
    addNewRoleLogic = AddNewRoleLogic(context: context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    addNewRoleLogic.dispose();
    super.dispose();
  }

  Role? get role => ModalRoute.of(context)!.settings.arguments as Role?;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addNewRoleLogic,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0.0,
          title: Text(
            role != null ? 'Chỉnh sửa chức vụ' : 'Thêm mới chức vụ',
            style: const TextStyle(
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
        ),
        body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelTextFieldCustom(value: "Tên chức vụ"),
                const SizedBox(
                  height: 10,
                ),
                TextFieldCustom(
                  controller: addNewRoleLogic.txtTitle
                    ..text = role != null ? role!.name : '',
                  placeholder: 'nhập tên chức vụ...',
                  onChanged: (val) {
                    addNewRoleLogic.updateValueTitle(val);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const LabelTextFieldCustom(value: "Chọn phân quyền"),
                const SizedBox(
                  height: 10,
                ),
                Consumer<AddNewRoleLogic>(
                  builder: (_, value, __) {
                    return Column(
                      children:
                          List.generate(addNewRoleLogic.lst.length, (index) {
                        return Selector<AddNewRoleLogic, bool>(
                          selector: (_, state) => state.test[index],
                          builder: (_, value, __) {
                            return ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: Checkbox(
                                value: addNewRoleLogic.test[index],
                                onChanged: (val) {
                                  addNewRoleLogic.changeValue(index);
                                },
                              ),
                              title: Text(
                                addNewRoleLogic.lst[index].name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                addNewRoleLogic.changeValue(index);
                              },
                            );
                          },
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<AddNewRoleLogic>(
                  builder: (_, value, __) {
                    return InkWell(
                      onTap: () {
                        role != null
                            ? addNewRoleLogic.updateRole(role!.id)
                            : addNewRoleLogic.addNewRole();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primary,
                        ),
                        child: Center(
                          child: Text(role != null ? 'Lưu' : 'Thêm',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )),
      ),
    );
  }
}
