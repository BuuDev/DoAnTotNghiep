part of 'viet_don_nghi_phep.dart';

class VietDonNghiPhepLogic extends ChangeNotifier {
  VietDonNghiPhepLogic();

  List<AnnualLeaveData> lstDonXinNghiPhep = [];
  List<AnnualLeaveData> lstSearch = [];
  int id = 3;
  bool isHideButtonSort = false;
  Leave service = Leave.client(isLoading: false);
  bool load = false;

  void getListAnnualLeave() async {
    try {
      await service.getAnnualListUser().then((value) {
        lstDonXinNghiPhep = value.annual_leave;
        lstSearch = lstDonXinNghiPhep;
        load = true;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void search(String key) {
    List<AnnualLeaveData> lstSearchtmp = [];
    for (AnnualLeaveData item in lstSearch) {
      if (item.start_date
              .contains(DateFormat('yyyy-MM').format(DateTime.parse(key))) &&
          key.trim().isNotEmpty) {
        lstSearchtmp.add(item);
      }
    }
    if (lstSearchtmp.isNotEmpty) {
      isHideButtonSort = true;
      lstDonXinNghiPhep = lstSearchtmp;
    } else if (key == '') {
      lstDonXinNghiPhep = lstSearch;
      isHideButtonSort = false;
    } else {
      lstDonXinNghiPhep = lstSearch;
      isHideButtonSort = false;
    }
    notifyListeners();
  }

  void delete(int id) async {
    try {
      await service.deleteDonNghiPhep(id).then((value) {
        NotifyHelper.showSnackBar(value.message);
        getListAnnualLeave();
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void restore() {
    lstDonXinNghiPhep = lstSearch;
    notifyListeners();
  }

  void sort() {
    lstDonXinNghiPhep = lstDonXinNghiPhep.reversed.toList();
    // lstSearch = lstDonXinNghiPhep;
    notifyListeners();
  }
}
