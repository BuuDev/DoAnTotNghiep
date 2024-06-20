part of 'work_manage.dart';

class WorkManagementLogic with ChangeNotifier {
  //Khởi tạo
  late BuildContext context;
  int index = 0;
  String title = 'Trang chủ';
  late PageController controller;
  double opacity = 0.5;
  late Animation<Color?> baseColor;
  late Animation<Color?> hightlightColor;
  late AnimationController animationController;
  bool hide = true;
  List<WorkModel>? data = [];
  List<WorkModel>? lstHienThi = [];
  WorkService api = WorkService.client(isLoading: false);

  final TextEditingController controllerSearch = TextEditingController();

  void getData() async {
    try {
      var response = await api.getWorkUser();
      data = response.data!;
      lstHienThi = data!;
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  String titleWork = "Skin Detective aaaaaaaa";

  WorkManagementLogic() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getData();
    });

    initController();
  }

  //animation của TA
  void activeAnimation() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    hide = false;
    await Future.delayed(const Duration(milliseconds: 100), () {});
    opacity = 1;
    notifyListeners();
  }

  bool active = false;

  void initController() {
    controller = PageController(initialPage: 0);
    notifyListeners();
  }

  void refresh() {
    Future.delayed(const Duration(seconds: 2));
    notifyListeners();
  }

  void setLstHienThi(String value) {
    lstHienThi = data!.where((e) {
      var name = e.name!.toLowerCase();
      return name.contains(value);
    }).toList();

    notifyListeners();
  }

  void returnSearch() {
    controllerSearch.text = '';
    FocusScope.of(context).unfocus();
    lstHienThi = data!;
    notifyListeners();
  }
}
