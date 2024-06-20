part of 'level.dart';

class LevelLogic with ChangeNotifier {
  late int checkMota = 0;
  String lableTask = "Thêm Tasks";
  LevelLogic() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    //controller = PageController(initialPage: 1, viewportFraction: .87);
  }

  TextEditingController controllerMoTa = TextEditingController();

  void setString(String value) {
    checkMota = value.length;
    if (checkMota <= 40) {
      lableTask = value;
    }
    notifyListeners();
  }
}
