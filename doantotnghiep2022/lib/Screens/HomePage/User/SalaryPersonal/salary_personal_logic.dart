part of 'salary_personal.dart';

class SalaryPersonalLogic extends ChangeNotifier {
  SalaryPersonalLogic() {
    getSalaryListPersonal(time);
  }

  List<SalaryData> data = [];
  SalaryService service = SalaryService.client(isLoading: false);
  DateTime time = DateTime.now();
  bool load = false;

  void getSalaryListPersonal(DateTime date) async {
    await service
        .getSalaryListUser(DateFormat('yyyy-MM').format(date))
        .then((value) {
      data = value.data;
      load = true;
      notifyListeners();
    });
  }

  changeTime(DateTime date) {
    time = date;
    getSalaryListPersonal(date);
    notifyListeners();
  }
}
