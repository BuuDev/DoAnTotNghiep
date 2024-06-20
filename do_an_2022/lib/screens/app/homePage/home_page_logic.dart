part of 'home_page.dart';

class HomePageLogic with ChangeNotifier {
  //Khởi tạo
  late BuildContext context;
  int index = 0;
  String title = 'Trang chủ';
  late PageController controller;

  late List<String> backGround = [
    "assets/icon/ocean.png",
    "assets/icon/green.png",
    "assets/icon/red.png",
    "assets/icon/yello.png",
    "assets/icon/primary.png",
    "assets/icon/orange.png"
  ];

  final TextEditingController controllerSearch = TextEditingController();

  List<WorkModel> item = [
    ...List.generate(
        5,
        (index) => WorkModel(
            id: index,
            userId: Random().nextInt(3),
            name: "Đồ án",
            status: "status",
            type: "0",
            priority: "priority",
            starting: DateTime(0),
            ending: DateTime(0),
            size: "size",
            rate: "rate",
            detail: "detail",
            background: "assets/icon/yellow.png",
            createdAt: null,
            updatedAt: null,
            deletedAt: null))
  ];
  List<WorkModel> lstHienThi = [];
  String titleWork = "Skin Detective aaaaaaaa";

  HomePageLogic() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //getPost();
    });
    lstHienThi = item;
    initController();
  }
  void reset() {
    changeIndex(0);
    index = 0;
    title = 'Trang chủ';
    controller = PageController(initialPage: 0);

    notifyListeners();
  }

  bool active = false;

  void initController() {
    controller = PageController(initialPage: 0);
    notifyListeners();
  }

  void changeIndexBottom(int index) {
    controller.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    notifyListeners();
  }

  void changeIndex(int value) async {
    //change index screen
    index = value;
    index == 0
        ? title = "Trang chủ"
        : index == 1
            ? title = "Thông báo"
            : title = "Tài khoản";
    notifyListeners();
    controller.jumpToPage(value);
    notifyListeners();
    // if (index == 0 && active == false) {
    //   callBack();
    // }
  }

  void refresh() {
    Future.delayed(Duration(seconds: 2));
    notifyListeners();
  }

  void callBack() {
    //get post
    //getPost();
    active = true;
    notifyListeners();
  }

  void setLstHienThi(String value) {
    lstHienThi = item.where((e) {
      var name = e.name.toLowerCase();
      return name.contains(value);
    }).toList();

    notifyListeners();
  }

  void returnSearch() {
    controllerSearch.text = '';
    FocusScope.of(context).unfocus();
    lstHienThi = item;
    notifyListeners();
  }

  bool checkBackGround(String backGroundWork) {
    if (backGroundWork == "assets/icon/green.png" ||
        backGroundWork == "assets/icon/red.png" ||
        backGroundWork == "assets/icon/yellow.png" ||
        backGroundWork == "assets/icon/orange.png" ||
        backGroundWork == "assets/icon/primary.png" ||
        backGroundWork == "assets/icon/ocean.png") {
      return true;
    } else {
      return false;
    }
  }
}
