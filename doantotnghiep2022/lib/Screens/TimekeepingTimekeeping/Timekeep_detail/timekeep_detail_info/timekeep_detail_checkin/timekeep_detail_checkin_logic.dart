part of 'timekeep_checkin.dart';

class CheckInLogic extends ChangeNotifier {
  late BuildContext context;
  TimeKeepService api = TimeKeepService.client();
  Leave leave = Leave.client();
  CheckInLogic() {
    tinhSoNgayLamViec(mouth.month, mouth.year);
  }
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime mouth = DateTime.now();
  int soNgayLam = 0;

  int ngayCong = 0;
  int nghiLam = 0;
  int chuaDuGio = 0;
  bool checkbutton = false;

  void selected(DateTime timeSelect, DateTime focus) {
    selectedDay = timeSelect;
    focusedDay = focus;

    notifyListeners();
  }

  void getDay(DateTime a) {
    tinhSoNgayLamViec(a.month, a.year);
    notifyListeners();
  }

  void tinhSoNgayLamViec(int thang, int nam) {
    // Tinh so ngay cua thang trong nam
    List<int> soNgayTrongThang = [
      31,
      28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    int soNgay = soNgayTrongThang[thang - 1];
    if (thang == 2 && (nam % 400 == 0 || (nam % 4 == 0 && nam % 100 != 0))) {
      soNgay++;
    }

    // Thu cua ngay dau thang
    DateTime date = DateTime.utc(nam, thang, 1);
    int thu = date.weekday;
    int soNgayTuHienTaiDenThuHaiTuanToi = 7 - thu + 1;
    int soNgayLamViecTuHienTaiDenThuHaiTuanToi =
        soNgayTuHienTaiDenThuHaiTuanToi - 2;
    if (soNgayLamViecTuHienTaiDenThuHaiTuanToi < 0) {
      soNgayLamViecTuHienTaiDenThuHaiTuanToi = 0;
    }

    // So tuan
    int tuan = (soNgay - soNgayTuHienTaiDenThuHaiTuanToi) ~/ 7;
    int soNgayLamViec = tuan * 5;

    // So ngay
    int duNgay = (soNgay - soNgayTuHienTaiDenThuHaiTuanToi) % 7;
    if (duNgay >= 5) {
      duNgay = 5;
    }
    soNgayLamViec += soNgayLamViecTuHienTaiDenThuHaiTuanToi;
    soNgayLamViec += duNgay;

    soNgayLam = soNgayLamViec;
    notifyListeners();
  }

  void onPageMouth(DateTime a, int id) async {
    mouth = a;
    getDay(a);
    nghiLam = 0;
    ngayCong = 0;
    chuaDuGio = 0;
    getData(DateFormat('yyyy-MM').format(DateTime.parse(a.toString())), id);
    notifyListeners();
  }

  bool checkEvent = true;

  DateTime now = DateTime.now();

  void checkEvents(DateTime a) {
    try {
      for (var item in data) {
        if (item.date != DateFormat('yyyy-MM-dd').format(a)) {
          checkbutton = false;
        }
        if (item.date == DateFormat('yyyy-MM-dd').format(a)) {
          if (item.status == '0' && item.checkout != null) {
            checkEvent = true;
            checkbutton = true;
            break;
          } else if (item.status == '1') {
            checkEvent = false;
            checkbutton = false;
            break;
          } else if (item.status == '2') {
            checkEvent = false;
            checkbutton = false;
            break;
          }
        } else if (item.date == DateFormat('yyyy-MM-dd').format(a)) {
          checkEvent = true;

          break;
        }
      }
      if (a.month == now.month && a.day > now.day) {
        checkEvent = false;
      } else if (a.month > now.month) {
        checkEvent = false;
      } else if (a.month < now.month) {
        checkEvent = false;
      } else if (a.year < now.year) {
        checkEvent = false;
      } else if (a.year > now.year) {
        checkEvent = false;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  List<TaskTimeKeepData> dataTask = [];
  void getTaskTimeKeep(int id, String date) async {
    try {
      var response = await api.getTask(id, date);
      dataTask = response.data;
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }

  List<TaskTimeKeepData> getEvent(DateTime date) {
    return dataTask;
  }

  void selectedEvent() {
    checkEvents(selectedDay);

    notifyListeners();
  }

  int idTest = 0;
  List<String> nghiLam1 = [];
  void xuLy(String start1, String end1) {
    DateTime start = DateTime.parse(start1);
    DateTime end = DateTime.parse(end1);
    nghiLam1 = [];
    var date = DateFormat('yyyy-MM').format(DateTime.parse(start1));

    for (var i = start.day; i <= end.day; i++) {
      if (i < 10) {
        nghiLam1.add(date + '-0$i');
      } else {
        nghiLam1.add(date + '-$i');
      }
    }
    for (var item in nghiLam1) {
      data.add(
        TimeKeepData(
          checkin: null,
          checkout: null,
          created_at: '',
          date: item,
          status: '',
          updated_at: '',
          user_id: idTest,
        ),
      );
    }
  }

  List<TimeKeepData> data = [];
  List<Annual> test = [];
  void getData([String? a, int? id]) async {
    try {
      idTest = id!;
      nghiLam1 = [];
      var response = await api.getTimekeep(month: a, id: id.toString());
      data = response.data.Timesheet!;
      test = response.data.AnnualLeave!;
      if (ngayCong != 0 || chuaDuGio != 0) {
        ngayCong = 0;
        chuaDuGio = 0;
        nghiLam = 0;
      }
      if (data.isEmpty) {
        nghiLam = 0;
      } else if (test.isEmpty) {
        nghiLam = 0;
      } else {
        for (var item in test) {
          if (item.user_id == id) {
            if (item.status == 1) {
              for (var i = DateTime.parse(item.start_date).day;
                  i <= DateTime.parse(item.finish_date).day;
                  i++) {
                xuLy(item.start_date, item.finish_date);
                nghiLam += item.total_day;
                break;
              }
            }
          }
        }
      }

      for (var item in data) {
        if (item.events() == 'đi làm') {
          ngayCong += 1;
        } else if (item.events() == 'đi muộn') {
          chuaDuGio += 1;
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }

  void timeKeep(String date) async {
    try {
      int idTimeKeep = 0;
      for (var item in data) {
        if (item.date == date) {
          idTimeKeep = item.id!;
          break;
        }
      }
      await api.chamCong(idTimeKeep.toString());
      checkEvent = false;
      checkbutton = false;
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }
}
