import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Widgets/LoadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';

void customLoading(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: LoadingWidget(),
              ),
            ),
          ),
        );
      });
}

void hideLoadingCustom(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
