part of 'department_management.dart';

class DepartmentManagementLogic extends ChangeNotifier {
  late BuildContext context;
  DepartmentManagementLogic({required this.context}) {
    getListDepartment();
  }
  TextEditingController txtAddNewPhongban = TextEditingController();
  DepartmentService service = DepartmentService.client();
  // List lstPhongban = [
  //   {'id': 1, 'title': 'Phòng nhân sự'},
  //   {'id': 2, 'title': 'Phòng IT'},
  //   {'id': 3, 'title': 'Phòng hành chính'},
  //   {'id': 4, 'title': 'Phòng marketing'},
  // ];
  List<Department> lstPhongban = [];
  List<Department> lstSearch = [];
  bool isHideButtonSort = false;
  int id = 4;

  void getListDepartment() async {
    try {
      await service.getListDepartment().then((value) {
        lstPhongban = value.data;
        lstSearch = lstPhongban;
        notifyListeners();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateTxtAddNewPhongBan(String key) {
    txtAddNewPhongban.text = key;
    notifyListeners();
  }

  void update(int id, String name) async {
    try {
      await service.updateDepartment(id, name).then((value) {
        NotifyHelper.showSnackBar(value.message);
        getListDepartment();
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void addNew() async {
    try {
      await service.addNewDepartment(txtAddNewPhongban.text).then((value) {
        NotifyHelper.showSnackBar(value.message);
        getListDepartment();
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void delete(int id) async {
    try {
      await service.deleteDepartment(id).then((value) => getListDepartment());
    } catch (e) {
      debugPrint('$e');
    }
  }

  void sort() {
    lstPhongban = lstPhongban.reversed.toList();
    lstSearch = lstPhongban;
    notifyListeners();
  }

  void search(String key) {
    List<Department> lstSearchtmp = [];
    for (Department item in lstSearch) {
      if (item.name.toLowerCase().contains(key.toLowerCase()) &&
          key.trim().isNotEmpty) {
        lstSearchtmp.add(item);
      }
    }
    if (lstSearchtmp.isNotEmpty) {
      isHideButtonSort = true;
      lstPhongban = lstSearchtmp;
    } else if (key == '') {
      lstPhongban = lstSearch;
      isHideButtonSort = false;
    } else {
      lstPhongban = lstSearch;
      isHideButtonSort = false;
    }
    notifyListeners();
  }
}
