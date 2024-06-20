import 'package:demo_retrofit_api/gen/assets.gen.dart';
import 'package:demo_retrofit_api/main.dart';
import 'package:demo_retrofit_api/screens/authentication/login/login.dart';
import 'package:demo_retrofit_api/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_loading_logic.dart';

class AuthLoadingPage extends StatefulWidget {
  const AuthLoadingPage({Key? key}) : super(key: key);

  @override
  State<AuthLoadingPage> createState() => _AuthLoadingPageState();
}

class _AuthLoadingPageState extends State<AuthLoadingPage> {
  late AuthLogic authLogic;
  @override
  void initState() {
    authLogic = AuthLogic(context: context);
    super.initState();
  }

  @override
  void dispose() {
    authLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: authLogic,
      child: Consumer<AuthLogic>(builder: (_, logic, __) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Assets.icon.logo.path),
              SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.tertiary),
                  strokeWidth: 6,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
