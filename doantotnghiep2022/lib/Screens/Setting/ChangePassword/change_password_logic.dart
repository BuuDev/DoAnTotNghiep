part of 'change_password.dart';

class ChangePasswordLogic extends ChangeNotifier {
  ChangePasswordLogic();
  String password = '';
  String errorPassword = '';
  String newPassword = '';
  String errorNewPassword = '';
  String confirmPassword = '';
  String errorConfirmPassword = '';
  bool showPassword = false;
  bool showPassword2 = false;
  bool showPassword3 = false;
  bool activeButton = false;
  DemoService service = DemoService.client();
  AccountLogic accountLogic = AccountLogic();

  void showPass(String type) {
    if (type == '1') {
      showPassword = !showPassword;
    }
    if (type == '2') {
      showPassword2 = !showPassword2;
    }
    if (type == '3') {
      showPassword3 = !showPassword3;
    }
    notifyListeners();
  }

  void update(String type, String value) {
    if (type == '1') {
      password = value;
      validatePass('1', password);
    }
    if (type == '2') {
      newPassword = value;
      validatePass('2', newPassword);
    }
    if (type == '3') {
      confirmPassword = value;
      validatePass('3', confirmPassword);
    }
    notifyListeners();
  }

  void validatePass(String type, String pass) {
    if (pass.trim().length < 6 && pass.trim().isNotEmpty) {
      if (type == '1') {
        errorPassword = 'Mật khẩu tối thiểu 6 kí tự';
      }
      if (type == '2') {
        errorNewPassword = 'Mật khẩu tối thiểu 6 kí tự';
      }
      if (type == '3') {
        errorConfirmPassword = 'Mật khẩu tối thiểu 6 kí tự';
      }
      if (pass.contains(' ')) {
        if (type == '1') {
          errorPassword = 'Mật khẩu không chứa khoảng trắng';
        }
        if (type == '2') {
          errorNewPassword = 'Mật khẩu không chứa khoảng trắng';
        }
        if (type == '3') {
          errorConfirmPassword = 'Mật khẩu không chứa khoảng trắng';
        }
      }
    } else if (pass.trim().isEmpty) {
      errorPassword = '';
      errorNewPassword = '';
      errorConfirmPassword = '';
      if (pass.contains(' ')) {
        if (type == '1') {
          errorPassword = 'Mật khẩu không chứa khoảng trắng';
        }
        if (type == '2') {
          errorNewPassword = 'Mật khẩu không chứa khoảng trắng';
        }
        if (type == '3') {
          errorConfirmPassword = 'Mật khẩu không chứa khoảng trắng';
        }
      }
    } else {
      errorPassword = '';
      errorNewPassword = '';
      errorConfirmPassword = '';
      if (pass.contains(' ')) {
        if (type == '1') {
          errorPassword = 'Mật khẩu không chứa khoảng trắng';
        }
        if (type == '2') {
          errorNewPassword = 'Mật khẩu không chứa khoảng trắng';
        }
        if (type == '3') {
          errorConfirmPassword = 'Mật khẩu không chứa khoảng trắng';
        }
      }
    }
    active();
    notifyListeners();
  }

  void active() async {
    if (errorPassword == '' &&
        errorNewPassword == '' &&
        errorConfirmPassword == '' &&
        password.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        newPassword == confirmPassword) {
      activeButton = true;
    } else {
      activeButton = false;
    }
    notifyListeners();
  }

  void changePassword(BuildContext context) async {
    if (activeButton == true) {
      try {
        await service
            .changePassword(password, newPassword, confirmPassword)
            .then((value) {
          NotifyHelper.showSnackBar(value.message);
          notifyListeners();
          if (value.message == 'Đổi mật khẩu thành công') {
            accountLogic.logout(context);
          }
        });
      } catch (e) {
        debugPrint('$e');
      }
    }
  }
}
