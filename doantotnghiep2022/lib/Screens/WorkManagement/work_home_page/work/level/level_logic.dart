part of 'level.dart';

class LevelLogic with ChangeNotifier {
  String lableTask = "Thêm Tasks";

  WorkService api = WorkService.client(isLoading: false);

  LevelLogic() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
    //controller = PageController(initialPage: 1, viewportFraction: .87);
  }
  WorkLogic workLogic = WorkLogic();

  TextEditingController controllerMoTa = TextEditingController();

  void setString(String value) {
    lableTask = value;

    notifyListeners();
  }

  Future<void> createLevel(int id_work, String lable) async {
    try {
      await api.createLevel(id_work, lable).then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> editLevel(int id_level, String lable) async {
    try {
      await api.editLevel(id_level, lable).then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> deleteLevel(int id_work) async {
    try {
      await api.deleteLevel(id_work).then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }
}
