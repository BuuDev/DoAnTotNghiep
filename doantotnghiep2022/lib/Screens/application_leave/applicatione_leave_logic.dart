part of 'application_leave.dart';

class ApplicationLogic extends ChangeNotifier {
  late BuildContext context;
  Leave service = Leave.client();
  late TabController tabController;

  ApplicationLogic({required this.context}) {
    //getData();
  }

  bool a = true;
  bool b = false;
  bool c = false;
  void check(int value) {
    if (value == 0) {
      c = false;
      b = false;
      a = true;
    } else if (value == 1) {
      c = false;
      a = false;
      b = true;
    } else {
      a = false;
      b = false;
      c = true;
    }
    notifyListeners();
  }
}
