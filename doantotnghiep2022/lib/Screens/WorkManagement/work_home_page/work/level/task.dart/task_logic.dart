part of 'task.dart';

class TaskLogic with ChangeNotifier {
  BuildContext context;
  late bool checkTask = false;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> images = [];
  bool hideLstTaskDetail = false;
  FocusNode focusNode = FocusNode();
  bool checkFocus = true;

  DemoService service = DemoService.client(isLoading: false);

  TextEditingController controllerWork = TextEditingController();

  FilePickerResult? result;
  PlatformFile? file;
  List<PlatformFile> lstFile = [];

  List<TaskPriority> lstTaskDetail = [];

  void deleteItem(int id, int id_task) {
    lstTaskDetail.removeWhere((element) => element.id == id);
    writeData(lstTaskDetail, id_task);
    notifyListeners();
  }

  void addItem(String lable, int id_task) {
    bool checklstId = true;
    for (int i = 1; checklstId == true; i++) {
      bool checkId = true;
      for (int j = 0; j < lstTaskDetail.length; j++) {
        if (lstTaskDetail[j].id == i) {
          checkId = false;
        }
      }
      if (checkId) {
        checklstId = false;
        lstTaskDetail.add(TaskPriority(
            id: i,
            code: "",
            name: lable,
            status: 0,
            createdAt: null,
            updatedAt: null,
            deletedAt: null));
      }
    }
    writeData(lstTaskDetail, id_task);
    notifyListeners();
  }

  int counterStatus() {
    int count = 0;
    for (int i = 0; i < lstTaskDetail.length; i++) {
      if (lstTaskDetail[i].status == 1) {
        count++;
      }
    }
    return count;
  }

  bool visible = true;
  String lableMota = "Chạm để thêm mô tả";
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerMoTa = TextEditingController();
  TextEditingController controllerComment = TextEditingController();
  List<UserDemo> lstAssign = [];
  LevelDemo lstLevel = LevelDemo(
      id: 0,
      userId: 0,
      name: '',
      status: '',
      progress: 0,
      type: '',
      priority: '',
      starting: null,
      ending: null,
      size: '',
      rate: '',
      detail: '',
      createdAt: '',
      updatedAt: '',
      level: []);

  TaskService apiTask = TaskService.client(isLoading: false);
  WorkService api = WorkService.client(isLoading: false);
  TaskLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  void hidelistTask(BuildContext context) {
    focusNode.requestFocus();
    hideLstTaskDetail = true;
    notifyListeners();
  }

  void returnTask() {
    checkTask = false;
    images = [];
    hideLstTaskDetail = false;
    focusNode = FocusNode();
    checkFocus = true;
    lstFile = [];
    visible = true;
    lableMota = "Chạm để thêm mô tả";
  }

  Future<void> selectFile() async {
    result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null) return;
    file = result!.files.first;
    lstFile.add(file!);
    //print(lstFile.toString());
    notifyListeners();
  }

  Future<void> createTask(int level_id, String title, String content,
      String timeStart, String timeOut) async {
    try {
      await apiTask
          .createTask(level_id, title, content, timeStart, timeOut)
          .then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> getLstLevel(int work_id) async {
    try {
      await api.getLevelWork(work_id).then((value) {
        var response = value.data;
        lstLevel = response!;
        print(lstLevel.level!.length);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> createComment(
    int task_id,
    String content,
  ) async {
    try {
      await apiTask
          .createComment(
        task_id,
        content,
      )
          .then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> editTask(int task_id, String title, String content,
      String timeStart, String timeOut) async {
    try {
      await apiTask
          .editTask(task_id, title, content, timeStart, timeOut)
          .then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void deleteUserTask(int id) async {
    try {
      await apiTask.deleteAssignUserTask(id).then((value) {
        NotifyHelper.showSnackBar(value.message);
      });
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> getlstAssignUser(List<TaskAssign> _lstAssign) async {
    lstAssign = [];
    await service.getListUser().then((value) {
      var lstSearchUser = value.user.data;
      for (int i = 0; i < _lstAssign.length; i++) {
        for (int j = 0; j < lstSearchUser!.length; j++) {
          if (_lstAssign[i].user_id == lstSearchUser[j].id) {
            lstAssign.add(lstSearchUser[j]);
          }
        }
      }
    });

    notifyListeners();
  }

  void changdeCheck(String value) {
    if (value.isEmpty) {
      checkFocus = true;
    } else {
      checkFocus = false;
    }

    notifyListeners();
  }

  Future<void> assignUser(int id, List<UserWork>? _lstAddUser) async {
    try {
      for (int i = 0; i < _lstAddUser!.length; i++) {
        await apiTask.assignUserTask(id, _lstAddUser[i].id).then((value) {
          NotifyHelper.showSnackBar(value.message);
        });
      }
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> deleteTask(int task_id) async {
    try {
      await apiTask.deleteTask(task_id).then((value) {
        NotifyHelper.showSnackBar(value.message);
      });

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> getSingleImage() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      images.addAll(selectedImages);
    }
    notifyListeners();
  }

  void removeImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  void updateImage(int index) async {
    final XFile? selectedImages =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImages != null) {
      images[index] = selectedImages;
    }
    notifyListeners();
  }

  void setString(String value) {
    lableMota = value;

    notifyListeners();
  }

  Future<String> chandgeDate(BuildContext context) async {
    var _currentdate = DateTime(0, 0, 0);
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate:
            _currentdate == DateTime(0, 0, 0) ? DateTime.now() : _currentdate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2200));
    _currentdate = newDate!;
    return _currentdate.toString();
  }

  void setCheckTask(bool value) {
    checkTask = !checkTask;
    value = checkTask;
    notifyListeners();
  }

  void readData(int id_task) async {
    final data = await SharedPreferences.getInstance();
    String? list = data.getString('$id_task');

    lstTaskDetail = [];

    var lstdata = json.decode(list ?? "[]") as List<dynamic>;
    lstTaskDetail = lstdata.map((e) => TaskPriority.fromJson(e)).toList();
  }

  void writeData(List<TaskPriority> lst, int id_task) async {
    final data = await SharedPreferences.getInstance();
    data.setString('$id_task', json.encode(lst));
    notifyListeners();
  }
}
