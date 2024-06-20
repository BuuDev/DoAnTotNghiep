part of 'task.dart';

class TaskLogic with ChangeNotifier {
  late DateTime _currentdate = DateTime(0, 0, 0);
  late int checkMota = 0;
  late bool checkTask = false;
  late Color color;
  TaskModel model = TaskModel(
      id: 0,
      title: "title",
      content: "content",
      index: 0,
      type: "type",
      timeOut: DateTime.now(),
      status: 0,
      levelId: 0,
      taskImages: [
        TaskImages(
            id: 0,
            url: "url",
            type: "type",
            name: "name",
            status: 0,
            createdAt: "createdAt",
            updatedAt: "updatedAt",
            deletedAt: "deletedAt")
      ],
      taskAttchaments: [
        TaskAttchaments(
            id: 0,
            url: "url",
            type: "type",
            name: "name",
            status: 0,
            createdAt: "createdAt",
            updatedAt: "updatedAt",
            deletedAt: "deletedAt")
      ],
      taskDetails: [
        TaskDetails(
            id: 0,
            description: "description",
            assignee: 0,
            reporter: 0,
            lable: "lable",
            priorityId: 0,
            status: 0,
            createdAt: "createdAt",
            updatedAt: "updatedAt",
            deletedAt: "deletedAt")
      ],
      taskSub: [
        TaskSub(
            id: 0,
            name: "name",
            status: 0,
            createdAt: "createdAt",
            updatedAt: "updatedAt",
            deletedAt: "deletedAt")
      ],
      createdAt: "createdAt",
      updatedAt: "updatedAt",
      deletedAt: "deletedAt");

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> images = [];

  bool visible = true;
  String lableMota = "Chạm để thêm mô tả";
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerMoTa = TextEditingController();
  TaskLogic() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
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
    checkMota = value.length;
    if (checkMota <= 300) {
      lableMota = value;
    }
    notifyListeners();
  }

  void chandgeDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate:
            _currentdate == DateTime(0, 0, 0) ? DateTime.now() : _currentdate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2200));
    if (newDate == null) return;
    _currentdate = newDate;
    notifyListeners();
  }

  void setCheckTask(bool value) {
    checkTask = !checkTask;
    value = checkTask;
    notifyListeners();
  }
}
