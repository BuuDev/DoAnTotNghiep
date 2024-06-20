part of 'work.dart';

class WorkLogic with ChangeNotifier {
  late PageController controller;

  bool checkHetHan = false;
  bool checkSapHetHan = false;
  WorkService api = WorkService.client(isLoading: false);
  bool checkAddWork = false;
  int index = 0;

  bool checkFocus = true;
  List<TaskItemModel> lstGarbage = [];

  List<UserWork> lstAddUser = [];
  List<UserWork>? lstSearchUser = [];
  List<UserWork>? lstUserSearchHienThi = [];

  WorkLogic() {
    controller = PageController(initialPage: 0, viewportFraction: .87);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  late LevelDemo? data;
  List<TaskModelDemo>? listTaskLevel = [];
  List<TaskModelDemo>? listHienThi = [];

  void returnWork() {
    data = null;
    checkHetHan = false;
    checkSapHetHan = false;
    checkAddWork = false;
    index = 0;
    listTaskLevel = [];
    listHienThi = [];
    lstSearchUser = [];
    lstUserSearchHienThi = [];
    lstAddUser = [];
    checkFocus = true;
    notifyListeners();
  }

  void setLstHienThi(String value) {
    lstUserSearchHienThi = lstSearchUser!.where((e) {
      var fullname = e.fullname.toLowerCase();
      var username = e.username.toLowerCase();
      return username.contains(value) || fullname.contains(value);
    }).toList();
    notifyListeners();
  }

  void addUser(int id, int workId) {
    for (int i = 0; i < lstUserSearchHienThi!.length; i++) {
      if (lstUserSearchHienThi![i].id == id) {
        lstAddUser.add(lstUserSearchHienThi![i]);
        lstUserSearchHienThi!.removeAt(i);
      }
    }
    notifyListeners();
  }

  void deleteUser(int id) {
    for (int i = 0; i < lstAddUser.length; i++) {
      if (lstAddUser[i].id == id) {
        lstUserSearchHienThi!.add(lstAddUser[i]);
        lstAddUser.removeAt(i);
      }
    }
    notifyListeners();
  }

  void changdeCheck(String value) {
    if (value.isEmpty) {
      checkFocus = true;
    } else {
      checkFocus = false;
    }

    notifyListeners();
  }

  Future<void> deleteWork(int id) async {
    try {
      await api.deleteWork(id).then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> getGarbage(int id) async {
    try {
      await api.garbageWork(id).then((value) {
        lstGarbage = value.data!;
        print(lstGarbage);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> getListTask(int work_id) async {
    try {
      await api.getTaskLevel(work_id).then((value) {
        var response = value.data;
        listTaskLevel = response;
        listHienThi = listTaskLevel;
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void setHienThi() {
    checkHetHan = false;
    checkSapHetHan = false;
    listHienThi = listTaskLevel;
    notifyListeners();
  }

  void hetHan() {
    checkHetHan = !checkHetHan;
    notifyListeners();
  }

  void sapHetHan() {
    checkSapHetHan = !checkSapHetHan;
    notifyListeners();
  }
}
