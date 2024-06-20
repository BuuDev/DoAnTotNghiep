import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Widgets/EmployItem/employ_item.dart';
import 'package:doantotnghiep/Widgets/TextFieldSearch/textfield_search.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'contract_logic.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({Key? key}) : super(key: key);

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  late ContractLogic contractLogic;
  @override
  void initState() {
    contractLogic = ContractLogic();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    contractLogic.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: contractLogic,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.transparent,
            elevation: 0.0,
            title: const Text(
              'Quản lí hợp đồng',
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
                    Navigator.pushNamed(context, Routes().contractManagement);
                  },
                  icon: const Icon(Icons.list_alt_outlined,
                      color: AppColors.textBlack))
            ],
            bottom: PreferredSize(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFieldSearch(
                  placeholder: 'Tìm kiếm nhân viên',
                  onChanged: (val) {},
                ),
              ),
              preferredSize: const Size.fromHeight(45),
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
                      Consumer<ContractLogic>(
                        builder: (_, value, __) {
                          return Text(
                            'Nhân viên (${contractLogic.lstUser.length})',
                            style: const TextStyle(
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
              Consumer<ContractLogic>(
                builder: (_, value, __) {
                  return Column(
                      children: List.generate(
                          contractLogic.lstUser.length,
                          (index) => EmployItem(
                                email: contractLogic.lstUser[index].email!,
                                avatar: contractLogic.lstUser[index].avatar,
                                name: contractLogic.lstUser[index].fullname,
                                icon: Icons.remove_red_eye_outlined,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes().contractPersonal,
                                      arguments:
                                          contractLogic.lstUser[index].id);
                                },
                              )));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
