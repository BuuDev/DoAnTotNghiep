part of 'add_new_role.dart';

class AddNewRoleLogic extends ChangeNotifier {
  late BuildContext context;
  Role? itemData = Role(id: 0, name: '', listPermission: []);
  List<bool> test = List.generate(50, (index) => false);
  TextEditingController txtTitle = TextEditingController();
  List<Permisstion> lst = [];
  String title = '';
  String lstIdPermisson = '';
  RoleService service = RoleService.client();
  AddNewRoleLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getListPermisson();
      check();
    });
  }

  void getListPermisson() async {
    await service.getListRole().then((value) => {lst = value.permission});
    check();
    notifyListeners();
  }

  void check() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      itemData = ModalRoute.of(context)!.settings.arguments as Role?;
      title = itemData!.name;
      for (Permisstion item in itemData!.listPermission) {
        for (Permisstion item2 in lst) {
          if (item2.name == item.name) {
            test[lst.indexOf(item2)] = true;
            lstIdPermisson += "${item2.id},";
            // print(lst.indexOf(item2));
            // print(item2.name);
          }
        }
      }
    }
    notifyListeners();
  }

  void changeValue(index) {
    test[index] = !test[index];
    if (test[index]) {
      if (!lstIdPermisson.contains("${lst[index].id},")) {
        lstIdPermisson += "${lst[index].id},";
      }
    } else {
      if (lstIdPermisson.contains("${lst[index].id},")) {
        lstIdPermisson = lstIdPermisson.replaceAll('${lst[index].id},', '');
      }
    }
    notifyListeners();
  }

  void updateValueTitle(val) {
    title = val;
    notifyListeners();
  }

  void addNewRole() async {
    // await service.createNewRole(title, lstIdPermisson).then((value) {
    //   NotifyHelper.showSnackBar(value.message);
    //   Navigator.pop(context);
    // });
    print(lstIdPermisson);
  }

  void updateRole(int id) async {
    await service.updateRole(id, lstIdPermisson).then((value) {
      // NotifyHelper.showSnackBar(value.message);
      // .pop(context);
    });
  }
}
