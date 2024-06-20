part of 'role_management.dart';

class RoleManagementLogic extends ChangeNotifier {
  late BuildContext context;
  RoleManagementLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getListRole();
    });
  }
  RoleService service = RoleService.client();
  List<Role> lst = [];

  void getListRole() async {
    try {
      await service.getListRole().then((value) {
        lst = value.role;
      });
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }
}
