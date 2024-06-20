import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/ResponseLogin/response.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Services/LocalStorage/local_storage.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
part 'auth_logic.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthLogic logic;

  @override
  void initState() {
    logic = AuthLogic(context: context);
    super.initState();
  }

  @override
  void dispose() {
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(Assets.images.iconBg.path),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
