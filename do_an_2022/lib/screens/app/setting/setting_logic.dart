part of 'setting.dart';

class SettingLogic with ChangeNotifier {
  late BuildContext context;
  SettingLogic({required this.context});
  List<bool> lstButton = [for (int i = 0; i < 13; i++) false];
  List<bool> lstBtnToggle = [for (int i = 0; i < 3; i++) false];

  void updateBtn(int index) {
    lstButton[index] = !lstButton[index];
    notifyListeners();
  }

  void updateBtnToggle(int index) {
    lstBtnToggle[index] = !lstBtnToggle[index];
    notifyListeners();
  }

  void removeTokenUser() async {
    final token = await SharedPreferences.getInstance();
    token.setString('token', "");
    context.read<HomePageLogic>().reset();
    notifyListeners();
  }
}
