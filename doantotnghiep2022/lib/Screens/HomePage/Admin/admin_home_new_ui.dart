import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'admin_home_new_ui_logic.dart';

class AdminHomeNewUI extends StatefulWidget {
  const AdminHomeNewUI({Key? key}) : super(key: key);

  @override
  State<AdminHomeNewUI> createState() => _AdminHomeNewUIState();
}

class _AdminHomeNewUIState extends State<AdminHomeNewUI> {
  late AdminHomeNewUILogic adminHomeNewUILogic;
  @override
  void initState() {
    super.initState();
    adminHomeNewUILogic = AdminHomeNewUILogic();
  }

  @override
  void dispose() {
    adminHomeNewUILogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: adminHomeNewUILogic,
      child: Scaffold(
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Text(
                  'Danh sách chức năng',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Monsserat",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    adminHomeNewUILogic.menu.length,
                    (index) => InkWell(
                      onTap: () {
                        adminHomeNewUILogic.menu[index]['onTap'](context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: index == 0 ? 15 : 5,
                            right: index == 5 ? 15 : 5),
                        width: 150,
                        decoration: BoxDecoration(
                          color: adminHomeNewUILogic.menu[index]
                              ['backgroundColor'],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child:
                                  Icon(adminHomeNewUILogic.menu[index]['icon']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0)
                                  .copyWith(bottom: 20),
                              child: Text(
                                adminHomeNewUILogic.menu[index]['title']
                                    .toUpperCase(),
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  fontFamily: "Monsserat",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
