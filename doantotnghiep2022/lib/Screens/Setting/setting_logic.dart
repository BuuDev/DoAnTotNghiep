part of 'setting.dart';

class SettingLogic extends ChangeNotifier {
  late BuildContext context;
  SettingLogic({required this.context}) {
    dartModeProvider = context.read<DarkModeProvider>();
  }
  bool activeButtonNotifi = false;
  bool activeButtonInfo = false;
  bool activeButtonDarkMode = false;
  bool activeSwitch = false;
  bool activeSwitchDarkMode =
      LocalStorage().getString('darkmode') == 'on' ? true : false;
  late DarkModeProvider dartModeProvider;
  void activeButtonNoti() {
    activeButtonNotifi = !activeButtonNotifi;
    notifyListeners();
  }

  void activeButtonInf() {
    activeButtonInfo = !activeButtonInfo;
    notifyListeners();
  }

  void activeButtonDark() {
    activeButtonDarkMode = !activeButtonDarkMode;
    notifyListeners();
  }

  void activeButtonSwitch() {
    activeSwitch = !activeSwitch;
    notifyListeners();
  }

  void activeButtonSwitchDark() {
    activeSwitchDarkMode = !activeSwitchDarkMode;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500),
        () => dartModeProvider.changeDarkMode());
  }

  void openPhone(String phone) async {
    try {
      await launchUrl(Uri.parse('tel:$phone'));
    } catch (e) {
      debugPrint('$e');
    }
  }

  // void test() {
  //   print('abc');
  // }
}
