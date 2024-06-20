part of 'timekeeping.dart';

class TimeKeepingLogic extends ChangeNotifier {
  late BuildContext context;
  TimeKeepService api = TimeKeepService.client();
  TimeKeepingLogic({required this.context}) {
    getData(currentDateShow);
  }

  DateTime date = DateTime.now();

  String currentDateShow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickerDate = await showDatePicker(
      locale: const Locale('vi', 'VN'),
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: date,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      builder: (context, _) {
        return Theme(
          data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.colorCard,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: AppColors.white),
          child: _!,
        );
      },
    );
    DateTime date1 = DateTime.now();
    if (pickerDate != null && pickerDate != date) {
      if (pickerDate.month == date1.month &&
          pickerDate.year == date1.year &&
          pickerDate.day <= date1.day) {
        date = pickerDate;
        currentDateShow = DateFormat('yyyy-MM-dd').format(date);
        getData(currentDateShow);
      } else {
        NotifyHelper.showSnackBar('Chọn ngày chấm công không phù hợp');
      }

      notifyListeners();
    }
  }

  List<TimeKeepData> data = [];
  void getData([String? a]) async {
    try {
      var response = await api.getTimekeep(month: a);

      data = response.data.Timesheet!;
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }

  void loadData() async {
    getData(currentDateShow);
    notifyListeners();
  }
}
