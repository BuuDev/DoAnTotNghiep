part of 'employee_management.dart';

class EmployeeManagementLogic extends ChangeNotifier {
  late BuildContext context;
  EmployeeManagementLogic({required this.context}) {
    getListUser();
  }
  DemoService service = DemoService.client(isLoading: false);
  bool load = false;
  int lst = 10;
  int df = 10;
  int step = 1;
  int total = 50;
  late bool isLoadMore = false;
  bool isSearch = true;
  List<UserDemo> lstUser = [];
  List<UserDemo> lstSearch = [];
  int totalSearch = 0;
  void sort() {
    lstUser = lstUser.reversed.toList();
    Navigator.pop(context);
    notifyListeners();
  }

  void searchUser(String key) async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    try {
      await service.searchUser(fullname: key).then((value) {
        if (value.user.data != []) {
          lstUser = value.user.data!;
          lst = lstUser.length;
          total = value.user.total;
          step = 1;
          isLoadMore = false;
        } else {
          lstUser = lstSearch;
          lst = lstUser.length;
          total = totalSearch;
          step = 1;
          isLoadMore = false;
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }

  void getListUser() async {
    await service.getListUser().then((value) {
      step = 1;
      lstUser = value.user.data!;
      lstSearch = lstUser;
      lst = lstUser.length;
      total = value.user.total;
      totalSearch = total;
      isLoadMore = false;
      load = true;
      notifyListeners();
    });
  }

  void loadMore() async {
    try {
      if (lst < total) {
        ++step;
        await service.getListUser(page: step).then((value) {
          lstUser = [...lstUser, ...value.user.data!];
          lstSearch = lstUser;
          lst = lstUser.length;
          notifyListeners();
        });
        if (lst > total) {
          lst = total;
        }
        notifyListeners();
      } else {
        isLoadMore = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
