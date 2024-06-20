part of 'contract.dart';

class ContractLogic extends ChangeNotifier {
  ContractLogic() {
    getListUser();
  }

  List<UserDemo> lstUser = [];
  DemoService service = DemoService.client();

  void getListUser() async {
    await service.getListUser().then((value) {
      lstUser = value.user.data!;
      notifyListeners();
    });
  }
}
