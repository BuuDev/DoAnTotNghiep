part of 'pending.dart';

class PendingLogic extends ChangeNotifier {
  late BuildContext context;
  Leave service = Leave.client(isLoading: true);

  PendingLogic({required this.context}) {
    getData();
  }
  bool checkNull = true;
  int sum = 0;
  bool checkLoad = false;

  List<AnnualLeaveData> data = [];
  void updateApprove(int id) async {
    try {
      var data = await service.approved(id.toString());

      if (data.success) {
        checkLoad = true;

        getData();
      }

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void getData() async {
    try {
      var approved = await service.getAnnualLeave();

      data = approved.annual_leave;
      sum = data.length;
      if (data.isEmpty) {
        checkNull = false;
      } else {
        checkNull = true;
      }

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void sort() {
    try {
      data = data.reversed.toList();

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void loadData() async {
    getData();
    notifyListeners();
  }
}
