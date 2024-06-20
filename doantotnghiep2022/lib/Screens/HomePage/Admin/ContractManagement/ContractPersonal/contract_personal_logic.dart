part of 'contract_personal.dart';

class ContractPersonalLogic extends ChangeNotifier {
  ContractPersonalLogic() {
    lstSearch = lst;
  }
  // TextEditingController txtSearch = TextEditingController();
  List<Contract> lst = [];

  List<Contract> lstSearch = [];
  bool isHideButtonSort = false;
  int id = 5;
  ContractService service = ContractService.client(isLoading: false);
  bool load = false;
  bool old = false;

  void getListContract(context) async {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      int id = ModalRoute.of(context)!.settings.arguments as int;
      await service
          .getAllListContract(userId: id, status: old ? 0 : null)
          .then((value) {
        lst = value.contract;
        lstSearch = lst;
        load = true;
      });
    }
    notifyListeners();
  }

  void changeValueOld(context) {
    old = !old;
    notifyListeners();
    getListContract(context);
  }

  void sort() {
    lst = lst.reversed.toList();
    lstSearch = lst;
    notifyListeners();
  }

  void search(String key) {
    List<Contract> lstSearchtmp = [];
    for (Contract item in lstSearch) {
      if (item.user!.fullname!.toLowerCase().contains(key.toLowerCase()) &&
          key.trim().isNotEmpty) {
        lstSearchtmp.add(item);
      }
    }
    if (lstSearchtmp.isNotEmpty) {
      isHideButtonSort = true;
      lst = lstSearchtmp;
    } else if (key == '') {
      lst = lstSearch;
      isHideButtonSort = false;
    } else {
      lst = lstSearch;
      isHideButtonSort = false;
    }
    notifyListeners();
  }

  void addNew(startDay, endDay, day) {
    notifyListeners();
  }

  // void update(int id, String content) {
  //   int item = lstSearch.indexWhere((element) => element['id'] == id);
  //   lstSearch[item]['title'] = content;
  //   notifyListeners();
  // }

  void delete(int id) {
    notifyListeners();
  }
}
