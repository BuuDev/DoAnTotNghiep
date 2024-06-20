import 'package:doantotnghiep/Screens/Account/account.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/admin_home.dart';
import 'package:doantotnghiep/Screens/HomePage/User/user_home.dart';
import 'package:doantotnghiep/Services/LocalStorage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'home_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String token;
  @override
  void initState() {
    super.initState();
    token = LocalStorage().getString('role')!;
    context.read<AccountLogic>().fillData();
  }

  @override
  Widget build(BuildContext context) {
    return token == 'admin' ? const AdminHomePage() : const UserHomePage();
  }
}
