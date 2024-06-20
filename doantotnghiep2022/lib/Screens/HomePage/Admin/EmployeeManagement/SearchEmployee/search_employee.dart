import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Widgets/TextFieldSearch/textfield_search.dart';
import 'package:flutter/material.dart';

class SearchEmployee extends StatefulWidget {
  const SearchEmployee({Key? key}) : super(key: key);

  @override
  State<SearchEmployee> createState() => _SearchEmployeeState();
}

class _SearchEmployeeState extends State<SearchEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0.0,
        title: const Text(
          'Tìm kiếm nhân viên',
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
        bottom: const PreferredSize(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextFieldSearch(
              placeholder: 'Tìm kiếm nhân viên',
              //
            ),
          ),
          preferredSize: Size.fromHeight(45),
        ),
      ),
    );
  }
}
