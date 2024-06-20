part of 'login.dart';

class LoginLogic with ChangeNotifier {
  final BuildContext context;
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: "");
  final returnPasswordController = TextEditingController(text: "");
  final UserService _userService = UserService.client();
  bool enableBtnLogin = ClientApi.mode() == EnvironmentMode.dev;
  Timer? _timer;

  LoginLogic({required this.context}) : super() {
    if (ClientApi.mode() == EnvironmentMode.dev) {
      emailController.text = 'testskin2022@gmail.com';
      passwordController.text = "abc@123";
    }
  }

  // String? onValidatorEmail(String? text) {
  //   if (text!.isNotEmpty) {
  //     if (!Validate.isEmail(text)) {
  //       return LocaleKeys.emailFormatErrorMess.tr();
  //     }
  //   }
  //   return null;
  // }

  Future<void> loginUser() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // Call API.
    try {
      var info = await _userService.getLogin(
          emailController.text, passwordController.text);
      loginSuccess(info);
    } catch (err) {
      debugPrint("In File: login_logic.dart, Line: 45 $err");
    }
  }

  String? onValidatorPassword(String? text) {
    return null;
  }

  void updateEmail(String email) {
    enableBtnLogin =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    notifyListeners();
  }

  void updatePassword(String password) {
    enableBtnLogin =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    notifyListeners();
  }

  // bool checkLogin() {
  //   if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
  //     NotifyHelper.showSnackBar(LocaleKeys.loginMessageErrorInfoNull.tr());
  //     return false;
  //   }
  //   return true;
  // }

  // void loginByGoogle() async {
  //   try {
  //     var googleInfo = await Helper.loginByGoogle(context);
  //     if (googleInfo != null && googleInfo.accessToken != null) {
  //       debugPrint('token: ${googleInfo.accessToken}');
  //       var info =
  //           await UserService.client().loginByGoogle(googleInfo.accessToken!);
  //       GetIt.instance<AppVM>().loginSuccess(info);
  //     } else {
  //       NotifyHelper.showSnackBar(LocaleKeys.loginMessageErrorLoginGmail.tr());
  //     }
  //   } on PlatformException catch (error) {
  //     debugPrint('$error');
  //   }
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
    super.dispose();
  }

  void loginSuccess(UserInfo info) async {
    if (info.accessToken != null) {
      // GetIt.instance<User>().updateInfo(info.user);
      // Save token
      LocalStorage().setExpireIn(info.expiresIn!);
      await LocalStorage().setToken(info.accessToken!);

      // authState = AuthState.logged;
      notifyListeners();

      if (!LocalStorage().getUserFirstLogged(info.user.id) &&
          info.user.avatar == null) {
        LocalStorage().setUserFirstLogged(info.user.id);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
  }

  void setTokenUser() async {
    final token = await SharedPreferences.getInstance();
    token.setString('token', "1");
    notifyListeners();
  }
}
