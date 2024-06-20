part of 'add_work.dart';

class AddWorkLogic with ChangeNotifier {
  BuildContext context;

  TextEditingController controllerSearch = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerMota = TextEditingController();

  WorkService api = WorkService.client(isLoading: false);
  DemoService service = DemoService.client(isLoading: false);
  bool checkFocus = true;
  List<UserDemo> lstAddUser = [];
  List<UserDemo>? lstSearchUser = [];
  List<UserDemo>? lstUserSearchHienThi = [];
  AddWorkLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
    //controller = PageController(initialPage: 1, viewportFraction: .87);
  }

  void getlstUserWork() async {
    await service.getListUser().then((value) {
      lstSearchUser = value.user.data;
      lstUserSearchHienThi = lstSearchUser;
      notifyListeners();
    });
    notifyListeners();
  }

  void deleteUserWork(int id) async {
    try {
      await api.deleteAssignUserWork(id).then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void setLstHienThi(String value) {
    lstUserSearchHienThi = lstSearchUser!.where((e) {
      var fullname = e.fullname!.toLowerCase();
      var username = e.username!.toLowerCase();
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

  Future<void> createWork(String? name, String? priority, String? starting,
      String? ending, String? size, String? detail) async {
    try {
      await api
          .createWork(name!, priority!, starting!, ending!, size!, detail!)
          .then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> assignUser(int id, List<UserDemo>? _lstAddUser) async {
    try {
      for (int i = 0; i < _lstAddUser!.length; i++) {
        await api.assignUserWork(id, _lstAddUser[i].id!).then((value) {
          NotifyHelper.showSnackBar(value.message);
        });
      }
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> editWork(int id, String? name, String? priority,
      String? starting, String? ending, String? size, String? detail) async {
    try {
      await api
          .editWork(id, name!, null, starting!, ending!, null, detail!)
          .then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void confirm(BuildContext context) {
    //Navigator.pop(context);
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
}
