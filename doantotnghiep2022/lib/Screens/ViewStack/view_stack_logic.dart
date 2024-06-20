part of 'view_stack.dart';

class ViewStackLogic extends ChangeNotifier {
  //Tất cả api ở màn hình chính đều call ở class Logic này
  //late BuildContext context;

  late DemoService ser;
  ViewStackLogic();
  List<DemoModels> data = [];
  bool isShowImageNetwork = true;
  int index = 0;
  int indexStorage = 0;
  String title = 'Trang Chủ';

  void updateValueIshowImageNetwork() {
    isShowImageNetwork = false;
    notifyListeners();
  }

  void changeIndexBottomNavBar(value) {
    index = value;
    if (index == 0) {
      indexStorage = value;
      title = 'Trang Chủ';
    }
    if (index == 1) {
      indexStorage = value;
      title = 'Quản lý công việc';
    }
    if (index == 2) {
      indexStorage = value;
      title = 'Chấm công';
    }
    if (index == 3) {
      indexStorage = value;
      title = 'Cài đặt';
    }
    // if (index == 4) {
    //   title = 'Thông tin tài khoản';
    // }
    // callBack();
    notifyListeners();
  }
  // void getApiDemo() async {
  //   try {
  //     data = await ser.getUsers();
  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // void callBack() {
  //   if (index == 1 && data.isEmpty) {
  //     getApiDemo();
  //   }
  // }

}
