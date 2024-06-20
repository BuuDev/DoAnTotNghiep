part of 'delete_approved.dart';

class DisApproveLogic extends ChangeNotifier {
  late BuildContext context;
  Leave service = Leave.client();

  DisApproveLogic({required this.context}) {
    getDataDis();
  }

  int sum = 0;
  bool checkNull = true;

  List<AnnualLeaveData> data = [];

  void getDataDis() async {
    try {
      var approved = await service.getListDisApprove();

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
    getDataDis();
    notifyListeners();
  }
}
