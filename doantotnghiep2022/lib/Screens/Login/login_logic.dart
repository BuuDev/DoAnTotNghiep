part of 'login.dart';

class LoginLogic extends ChangeNotifier {
  late BuildContext context;
  LoginLogic({required this.context});
  late final TextEditingController txtEmail =
      TextEditingController(text: 'superadmin');
  late final TextEditingController txtPassword =
      TextEditingController(text: '123456');
  String errorEmail = '';
  String errorPassword = '';
  bool showPassword = false;
  // DemoService service =
  //     DemoService(Dio(), baseUrl: 'http://sd-api.pixelcent.com/v2');
  DemoService service = DemoService.client();
  void validateEmail(String email) {
    if (!email.isEmail() && email.trim().isNotEmpty) {
      errorEmail = 'Email không hợp lệ';
    } else if (email.trim().isEmpty) {
      errorEmail = '';
      if (email.contains(' ')) {
        errorEmail = 'Email không chứa khoảng trắng';
      }
    } else {
      errorEmail = '';
      if (email.contains(' ')) {
        errorEmail = 'Email không chứa khoảng trắng';
      }
    }
    txtEmail.text = email;
    notifyListeners();
  }

  void validateUsername(String username) {
    if (username.trim().isEmpty) {
      errorEmail = '';
    } else {
      errorEmail = '';
      if (username.contains(' ')) {
        errorEmail = 'Tên tài khoản không chứa khoảng trắng!';
      }
    }
    txtEmail.text = username;
    notifyListeners();
  }

  void validatePass(String pass) {
    if (pass.trim().length < 6 && pass.trim().isNotEmpty) {
      errorPassword = 'Mật khẩu tối thiểu 6 kí tự';
      if (pass.contains(' ')) {
        errorPassword = 'Mật khẩu không chứa khoảng trắng';
      }
    } else if (pass.trim().isEmpty) {
      errorPassword = '';
      if (pass.contains(' ')) {
        errorPassword = 'Mật khẩu không chứa khoảng trắng';
      }
    } else {
      errorPassword = '';
      if (pass.contains(' ')) {
        errorPassword = 'Mật khẩu không chứa khoảng trắng';
      }
    }
    txtPassword.text = pass;
    notifyListeners();
  }

  void showPass() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void login({String? username, String? password}) async {
    try {
      ResponseUser data = await service.login(
          username ?? txtEmail.text, password ?? txtPassword.text);
      await LocalStorage().store.setString('username', txtEmail.text);
      await LocalStorage().store.setString('password', txtPassword.text);
      await LocalStorage().store.setString('token', data.access_token);
      await LocalStorage().store.setString('status', 'login');
      await LocalStorage().store.setString('role',
          data.user.roleId == 1 || data.user.roleId == 2 ? 'admin' : 'user');
      await LocalStorage().store.setString('userData', json.encode(data.user));
      Navigator.pushReplacementNamed(context, Routes().viewStack);
    } catch (e) {
      debugPrint(e.toString());
    }
    //print(LocalStorage().getString('userData'));
  }
}
