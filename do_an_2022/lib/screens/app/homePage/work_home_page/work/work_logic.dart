part of 'work.dart';

class WorkLogic with ChangeNotifier {
  late PageController controller;

  bool checkHetHan = false;
  bool checkSapHetHan = false;

  bool checkAddWork = false;
  int index = 0;

  List<LevelItem> list = [];
  List<LevelItem> listHienThi = [];
  List<TaskModel> listTask = [
    ...List.generate(
      4,
      (index) => TaskModel(
          id: index,
          title: "Cần làm $index",
          content: "content",
          index: 0,
          type: "type",
          timeOut: DateTime(0),
          status: Random().nextInt(3),
          levelId: Random().nextInt(3),
          taskImages: [],
          taskAttchaments: [],
          taskDetails: [],
          taskSub: [],
          createdAt: null,
          updatedAt: null,
          deletedAt: null),
    ),
    ...List.generate(
      2,
      (index) => TaskModel(
          id: index + 4,
          title: "Đang Làm $index",
          content: "content",
          index: 0,
          type: "type",
          timeOut: DateTime(0),
          status: Random().nextInt(3),
          levelId: Random().nextInt(3),
          taskImages: [],
          taskAttchaments: [],
          taskDetails: [],
          taskSub: [],
          createdAt: null,
          updatedAt: null,
          deletedAt: null),
    ),
    ...List.generate(
      1,
      (index) => TaskModel(
          id: index + 6,
          title: "Đã xong $index",
          content: "content",
          index: 0,
          type: "type",
          timeOut: DateTime(0),
          status: Random().nextInt(3),
          levelId: Random().nextInt(3),
          taskImages: [],
          taskAttchaments: [],
          taskDetails: [],
          taskSub: [],
          createdAt: null,
          updatedAt: null,
          deletedAt: null),
    )
  ];
  WorkLogic() {
    controller = PageController(initialPage: 0, viewportFraction: .87);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  //phân list Task theo level
  List<TaskModel> listTaskLevel(int id) {
    List<TaskModel> list = [];
    for (int i = 0; i < listTask.length; i++) {
      if (listTask[i].levelId == id) {
        list.add(listTask[i]);
      }
    }
    return list;
  }

  Color backGroundWord(String value) {
    switch (value) {
      case "assets/icon/green.png":
        return AppColors.green;
      case "assets/icon/orange.png":
        return AppColors.orange;
      case "assets/icon/yellow.png":
        return AppColors.yellow;
      case "assets/icon/red.png":
        return AppColors.red;
      case "assets/icon/primary.png":
        return AppColors.primary;
      case "assets/icon/ocean.png":
        return AppColors.ocean;
      default:
        return AppColors.gray;
    }
  }

  void setHienThi() {
    checkHetHan = false;
    checkSapHetHan = false;
    listHienThi = list;
    notifyListeners();
  }

  //tạo list level chưa list Task theo id
  Future<void> setListTaskLevel() async {
    for (int i = 0; i < listTask.length; i++) {
      list.add(LevelItem(
          id: listTask[i].levelId, listTask: listTaskLevel(listTask[i].id)));
    }
  }

  //lấy list task theo id level
  List<TaskModel> lst(int id) {
    late List<TaskModel> lst = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        lst = list[i].listTask!;
      }
    }
    return lst;
  }

  late List<Widget> listPageLevel = List.generate(
      listLevel.length,
      (index) => Level(
            id: listLevel[index].id,
          ));

  List<LevelModel> listLevel = [
    LevelModel(
        id: 0,
        name: "Những việc cần làm",
        index: 0,
        status: 0,
        createdAt: null,
        updatedAt: null,
        deletedAt: null),
    LevelModel(
        id: 1,
        name: "Đang làm",
        index: 1,
        status: 0,
        createdAt: null,
        updatedAt: null,
        deletedAt: null),
    LevelModel(
        id: 2,
        name: "Đã xong",
        index: 2,
        status: 0,
        createdAt: null,
        updatedAt: null,
        deletedAt: null),
  ];

  List<TaskModel> setHienThifilter(bool item1, bool item2, int index) {
    List<TaskModel> _list = [];
    if (list[index].listTask!.isNotEmpty) {
      for (int i = 0; i < list[index].listTask!.length; i++) {
        if (item1 && item2) {
          if (list[index].listTask![i].status == 1 ||
              list[index].listTask![i].status == 2) {
            _list.add(list[index].listTask![i]);
            print(list[index].listTask![i].status);
          }
        } else {
          if (item1 && !item2) {
            if (list[index].listTask![i].status == 1) {
              _list.add(list[index].listTask![i]);
              print(list[index].listTask![i].status);
            }
          }
          if (!item1 && item2) {
            if (list[index].listTask![i].status == 2) {
              _list.add(list[index].listTask![i]);
              print(list[index].listTask![i].status);
            }
          }
        }
      }
    }
    return _list;
  }

  void filter(bool item1, bool item2) {
    listHienThi = List.generate(
        list.length,
        (index) => LevelItem(
            id: list[index].id,
            listTask: setHienThifilter(item1, item2, index)));
    notifyListeners();
  }

  void HetHan() {
    checkHetHan = !checkHetHan;
    notifyListeners();
  }

  void SapHetHan() {
    checkSapHetHan = !checkSapHetHan;
    notifyListeners();
  }
}
