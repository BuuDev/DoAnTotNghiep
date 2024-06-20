part of 'add_new_don_xin_nghi_phep.dart';

class AddNewDonXinNghiPhepLogic extends ChangeNotifier {
  late BuildContext context;
  AddNewDonXinNghiPhepLogic({required this.context});
  TextEditingController txtLido = TextEditingController(text: '');
  String startDay = 'dd/ mm/ yyyy';
  String endDay = 'dd/ mm/ yyyy';
  String lido = '';
  Leave service = Leave.client(isLoading: true);
  void addNew(int userId) async {
    await service
        .createAnnualLeave(startDay, endDay, userId.toString(), lido)
        .then((value) {
      NotifyHelper.showSnackBar(value.message);
      Navigator.pop(context, true);
    });
    notifyListeners();
  }

  void updateAnnualLeave(int id, int userId) async {
    await service
        .updateAnnualLeave(id, startDay, endDay, userId.toString(), lido)
        .then((value) {
      NotifyHelper.showSnackBar(value.message);
      Navigator.pop(context, true);
    });
  }

  void updateStartDay(value1, {value2}) {
    try {
      if (value1 != null) {
        startDay = DateFormat('yyyy-MM-dd').format(value1);
        endDay = DateFormat('yyyy-MM-dd').format(value2);
      }
    } catch (e) {
      if (value1 != null) {
        startDay = DateFormat('yyyy-MM-dd').format(DateTime.parse(value1));
        endDay = DateFormat('yyyy-MM-dd').format(DateTime.parse(value2));
      }
    }
    notifyListeners();
  }

  void updateEndDay(value) {
    try {
      if (value != null) {
        endDay = DateFormat('yyyy-MM-dd 00:00:00').format(value);
      }
    } catch (e) {
      if (value != null) {
        endDay =
            DateFormat('yyyy-MM-dd 00:00:00').format(DateTime.parse(value));
      }
    }
    notifyListeners();
  }

  void updateTxtLido(val) {
    lido = val;
    notifyListeners();
  }
}
