part of 'auth.dart';

class AuthLogic extends ChangeNotifier {
  late BuildContext context;
  String checkToken = '';
  AuthLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      initLocalStorage();
    });
  }
  DemoService service = DemoService.client(isLoading: false);

  initLocalStorage() async {
    await LocalStorage.init();
    String? status = LocalStorage().getString('status');
    String? username = LocalStorage().getString('username') ?? '';
    String? password = LocalStorage().getString('password') ?? '';
    checkToken = LocalStorage().token;
    //kiểm tra đăng nhập hay chưa qua token
    if (checkToken.isEmpty) {
      Future.delayed(const Duration(milliseconds: 1000),
          () => Navigator.pushReplacementNamed(context, '/login'));
    } else {
      if (status!.isEmpty) {
        ResponseUser data = await service.login(username, password);
        await LocalStorage().store.setString('token', data.access_token);
        Future.delayed(const Duration(milliseconds: 1000),
            () => Navigator.pushReplacementNamed(context, '/view_stack'));
      }
      //  else {
      //   Future.delayed(const Duration(milliseconds: 1000),
      //       () => Navigator.pushReplacementNamed(context, '/view_stack'));
      //   print('mới login');
      // }
      //sau này sẽ call để lấy thông tin user ở đây

    }
    notifyListeners();
  }
}
