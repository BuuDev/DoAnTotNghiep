part of 'application_detail.dart';

class DetailLogic extends ChangeNotifier {
  late BuildContext context;
  Leave service = Leave.client();
  late ApplicationLogic logic;
  DetailLogic({required this.context});
  TextEditingController controller = TextEditingController();

  void updateApprove(int id) async {
    try {
      var response = await service.approved(id.toString());

      if (response.success) {
        Navigator.pop(context);
        Navigator.pop(context);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  bool checkEmpty = false;

  void disApp(int id, String lyDo) async {
    try {
      var response = await service.disapproved(id.toString(), lyDo);
      Navigator.pop(context);

      if (response.success) {
        Navigator.pop(context);
      }
      clear();

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void clear() {
    controller.clear();
    checkEmpty = false;
    notifyListeners();
  }

  void check() {
    if (controller.text.trim().isEmpty) {
      checkEmpty = false;
    } else {
      checkEmpty = true;
    }
    notifyListeners();
  }
}
