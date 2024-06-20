part of 'add_work.dart';

class AddWorkLogic with ChangeNotifier {
  bool checkFocus = true;
  TextEditingController controller = TextEditingController();
  List<User> lstAddUser = [];
  List<User>? lstSearchUser = [
    ...List.generate(
        5,
        (index) => User(
            id: index,
            name: "User ${index}",
            username: "${Random().nextInt(5) + 1}",
            email: "email",
            avatar: "avatar",
            roleId: 0,
            nationnalityId: 0,
            password: "password",
            token: "token",
            opt: "opt",
            expiredTime: null,
            activel: null,
            googleId: null,
            status: Random().nextInt(2),
            phone: null,
            provider: null,
            expiredTimeOtp: null,
            lasteLogin: null,
            createdAt: null,
            updatedAt: null,
            deletedAt: null))
  ];
  List<User> lstUserSearchHienThi = [];
  AddWorkLogic() {
    lstUserSearchHienThi = lstSearchUser!;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    //controller = PageController(initialPage: 1, viewportFraction: .87);
  }

  void addUser(int id) {
    for (int i = 0; i < lstSearchUser!.length; i++) {
      if (lstSearchUser![i].id == id) {
        lstAddUser.add(lstSearchUser![i]);
        lstSearchUser!.removeAt(i);
      }
    }

    notifyListeners();
  }

  void confirm(BuildContext context) {
    //Navigator.pop(context);
    notifyListeners();
  }

  void deleteUser(int id) {
    for (int i = 0; i < lstAddUser.length; i++) {
      if (lstAddUser[i].id == id) {
        lstSearchUser!.add(lstAddUser[i]);
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
    print(checkFocus);
    notifyListeners();
  }
}
