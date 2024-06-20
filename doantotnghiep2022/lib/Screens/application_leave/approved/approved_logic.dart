part of 'approved.dart';

class ApprovedLogic extends ChangeNotifier {
  late BuildContext context;
  Leave service = Leave.client();

  ApprovedLogic({required this.context}) {
    getData();
  }

  int sum = 0;
  bool checkNull = true;

  List<AnnualLeaveData> data = [];

  void getData() async {
    try {
      var approved = await service.getApproved();

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
