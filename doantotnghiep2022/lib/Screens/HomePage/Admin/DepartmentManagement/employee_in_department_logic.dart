part of 'employee_in_department.dart';

class EmployeeInDepartmentLogic extends ChangeNotifier {
  late BuildContext context;
  EmployeeInDepartmentLogic({required this.context});

  DemoService service = DemoService.client();

  List<UserDemo> data = [];
  String title = '';

  void getEployeeInDepartment(int id) async {
    await service.getListUser(departmentId: id).then((value) {
      data = value.user.data!;
      if (data.isNotEmpty) {
        title = value.user.data![0].department!.name;
      }
      notifyListeners();
    });
  }
}
