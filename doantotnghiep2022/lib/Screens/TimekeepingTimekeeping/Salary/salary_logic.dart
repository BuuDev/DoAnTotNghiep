part of 'salary.dart';

class SalaryLogic extends ChangeNotifier {
  late BuildContext context;
  SalaryLogic({required this.context});

  DateTime date = DateTime.now();

  String currentDateShow =
      DateTime.now().month.toString() + '-' + DateTime.now().year.toString();

  int month = DateTime.now().month.toInt();
  int year = DateTime.now().year.toInt();
  void add() {
    month += 1;
    if (month > 12) {
      month = 1;
      year += 1;
    }

    currentDateShow = month.toString() + '-' + year.toString();
    notifyListeners();
  }

  void reduce() {
    month -= 1;
    if (month == 0) {
      month = 12;
      year -= 1;
    }

    currentDateShow = month.toString() + '-' + year.toString();
    notifyListeners();
  }
}
