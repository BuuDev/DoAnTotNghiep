part of 'salary_management.dart';

class SalaryManagementLogic extends ChangeNotifier {
  late BuildContext context;

  SalaryService service = SalaryService.client();
  SalaryManagementLogic({required this.context}) {
    // Future.delayed(const Duration(milliseconds: 2000), () {
    // });
    getData();
  }

  DateTime date = DateTime.now();
  bool checkMonth = false;
  bool checkAnimation = true;

  String currentDateShow = DateFormat('yyyy-MM').format(DateTime.now());

  List<SalaryData> data = [];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickerDate = await showMonthPicker(
      locale: const Locale('vi', 'VN'),
      context: context,
      initialDate: date,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );

    if (pickerDate != null && pickerDate != date) {
      date = pickerDate;
      currentDateShow = DateFormat('yyyy-MM').format(date);
      getDataMonth(currentDateShow);
    }
    notifyListeners();
  }

  void getData() async {
    var getdata = await service.getSalary(currentDateShow);

    try {
      data = getdata.data;

      if (getdata.data.isEmpty) {
        checkAnimation = false;
      } else {
        checkAnimation = true;
      }
      checkMonth = true;
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void getDataMonth(String month) async {
    try {
      var getdata = await service.getSalary(month);

      data = getdata.data;

      if (getdata.data.isEmpty) {
        checkAnimation = false;
      } else {
        checkAnimation = true;
      }
      checkMonth = true;

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void getData1() {
    //data = data2;
    notifyListeners();
  }

  void loadData() {
    getData();
  }
}
