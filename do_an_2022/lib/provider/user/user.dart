import 'package:flutter/material.dart';

import '../../Models/user/user.dart';

class UserViewModel with ChangeNotifier {
  // User data = User.userEmpty;

  UserViewModel() {
    _initData();
  }

  void _initData() async {
    // data = LocalStorage().userInfo ?? User.userEmpty;
    notifyListeners();
  }

  void updateInfo(User info) {
    // data = info;
    notifyListeners();

    // LocalStorage().setInfoUser(data);
  }

  ///Request api to get info
  // Future<void> requestInfo() async {
  //   try {
  //     var info =
  //         await UserService.client(isLoading: false)
  //             .getInfo();
  //     data = info;
  //     // await NavigationService.gotoAppStack();
  //     notifyListeners();
  //     return Future.value();
  //   } on DioError catch (e) {
  //     debugPrint('$e');
  //     return Future.error(e);
  //   }
  // }

  // void reset() {
  //   data = User.userEmpty;
  //   notifyListeners();
  // }
}
