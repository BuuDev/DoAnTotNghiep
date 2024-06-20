part of 'contract_management.dart';

class ContractManagementLogic extends ChangeNotifier {
  ContractManagementLogic() {
    getAllListContract();
    // getListContractIsAboutToExpire();
  }
  // TextEditingController txtSearch = TextEditingController();
  List<Contract> lst = [];
  List<Contract> lstSearch = [];
  List<Contract> lstContractIsAboutToExpire = [];
  List<Contract> lstSearch2 = [];
  bool isHideButtonSort = false;
  bool isHideButtonSort2 = false;
  int id = 5;
  ContractService service = ContractService.client(isLoading: false);
  bool load = false;
  bool old = false;

  void getAllListContract() async {
    await service.getAllListContract(status: old ? 0 : null).then((value) {
      lst = value.contract;
      lstSearch = lst;
      getListContractIsAboutToExpire();
      notifyListeners();
    });
  }

  void changeValueOld(context) {
    old = !old;
    notifyListeners();
    getAllListContract();
  }

  void getListContractIsAboutToExpire() async {
    await service.getListContractIsAboutToExpire().then((value) {
      lstContractIsAboutToExpire = value.contract;
      lstSearch2 = lstContractIsAboutToExpire;
      load = true;
      notifyListeners();
    });
  }

  void sort() {
    lst = lst.reversed.toList();
    lstSearch = lst;
    notifyListeners();
  }

  void sort2() {
    lstContractIsAboutToExpire = lstContractIsAboutToExpire.reversed.toList();
    lstSearch2 = lstContractIsAboutToExpire;
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

  void search2(String key) {
    List<Contract> lstSearchtmp = [];
    for (Contract item in lstSearch2) {
      if (item.user!.fullname!.toLowerCase().contains(key.toLowerCase()) &&
          key.trim().isNotEmpty) {
        lstSearchtmp.add(item);
      }
    }
    if (lstSearchtmp.isNotEmpty) {
      isHideButtonSort2 = true;
      lstContractIsAboutToExpire = lstSearchtmp;
    } else if (key == '') {
      lstContractIsAboutToExpire = lstSearch2;
      isHideButtonSort2 = false;
    } else {
      lstContractIsAboutToExpire = lstSearch2;
      isHideButtonSort2 = false;
    }
    notifyListeners();
  }

  void addNew(name, startDay, endDay, day) {
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
