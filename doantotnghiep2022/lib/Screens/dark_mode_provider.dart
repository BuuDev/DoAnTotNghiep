import 'package:doantotnghiep/Services/LocalStorage/local_storage.dart';
import 'package:flutter/cupertino.dart';

class DarkModeProvider extends ChangeNotifier {
  bool darkmode = false;
  DarkModeProvider() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      initLocalStorage();
    });
  }

  void initLocalStorage() async {
    await LocalStorage.init();
    darkmode = LocalStorage().getString('darkmode') == 'on' ? true : false;
    notifyListeners();
  }

  void changeDarkMode() {
    darkmode = !darkmode;
    if (darkmode) {
      LocalStorage().store.setString('darkmode', 'on');
    } else {
      LocalStorage().store.setString('darkmode', 'of');
    }
    notifyListeners();
  }
}
