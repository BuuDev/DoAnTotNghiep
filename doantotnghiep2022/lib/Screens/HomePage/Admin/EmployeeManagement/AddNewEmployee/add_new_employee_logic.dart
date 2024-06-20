part of 'add_new_employee.dart';

class AddNewEmployeeLogic extends ChangeNotifier {
  late BuildContext context;
  AddNewEmployeeLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getListDepartmentAndListRoles();
    });
  }
  DemoService service = DemoService.client();
  int id = 0;
  String name = '';
  String errorName = '';
  String birthday = 'dd/ mm/ yyyy';
  String phone = '';
  String errorPhone = '';
  String cmnd = '';
  String errorCmnd = '';
  String email = '';
  String errorEmail = '';
  String address = '';
  String errorAddress = '';
  String username = '';
  String errorUsername = '';
  String password = '';
  String avatar = '';
  TextEditingController txtSearch = TextEditingController();
  String errorPassword = '';
  bool showPassword = false;
  String textName = '';
  Department phongban = Department(id: 0, name: '');
  RoleUser chucvu = RoleUser(id: 0, name: '');

  List<Department> lstPhongban = [];
  List<RoleUser> lstChucvu = [];
  bool isShow = true;

  void show() {
    isShow = false;
    notifyListeners();
  }

  final ImagePicker picker = ImagePicker();
  XFile? image;
  File? imageShow;

  void getListDepartmentAndListRoles() async {
    try {
      await service.getListUser().then((value) {
        lstPhongban = value.department;
        lstChucvu = value.role;
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void fillValueUdate(UserDemo? user) {
    id = user!.id!;
    name = user.fullname!;
    birthday = user.birthday!;
    phone = user.phone!;
    cmnd = user.citizenIdentification!;
    email = user.email!;
    address = user.address!;
    username = user.username!;
    phongban.id = user.departmentId!;
    chucvu.id = user.roleId!;
    phongban.name = user.department!.name;
    chucvu.name = user.role!.name;
    avatar = user.avatar != null ? user.avatar! : '';

    notifyListeners();
  }

  void addNewEmoloyee() async {
    validate('name', name);
    if (errorName.isEmpty) {
      await service
          .addNewEmployee(name, username, password, birthday, phone, address,
              cmnd, email, chucvu.id, phongban.id, imageShow)
          .then((value) {
        NotifyHelper.showSnackBar(value.message);
        Navigator.pop(context, true);
      });
    }
  }

  void updateEmoloyee() async {
    validate('name', name);
    if (errorName.isEmpty) {
      await service
          .updateEmployee(id, name, username, birthday, phone, address, cmnd,
              email, chucvu.id, phongban.id, imageShow)
          .then((value) => Navigator.pop(context, true));
    }
  }

  void validate(String type, String value) {
    if (type == 'name') {
      if (value.isEmpty) {
        errorName = 'Vui lòng nhập họ tên';
      }
    }
    notifyListeners();
  }

  void updateBirthday(value) {
    if (value != null) {
      birthday = DateFormat('yyyy-MM-dd').format(value);
    }
    notifyListeners();
  }

  void updateProvince(value) {
    address = value;
    notifyListeners();
  }

  void selectImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      image = value;
    });
    if (image != null) {
      imageShow = File(image!.path);
    }
    notifyListeners();
  }

  void update(String type, String value) {
    if (type == 'name') {
      name = value;
    }
    if (type == 'phone') {
      phone = value;
      if (phone.isEmpty) {
        errorPhone = '';
      }
      if (phone.isNotEmpty && !phone.isNumeric()) {
        errorPhone = 'số điện thoại không đúng định dạng!';
      } else {
        errorPhone = '';
      }
    }
    if (type == 'cmnd') {
      cmnd = value;
      if (cmnd.isEmpty) {
        errorCmnd = '';
      }
      if (cmnd.isNotEmpty && !cmnd.isNumeric()) {
        errorCmnd = 'CMND/CCCD không đúng định dạng!';
      } else {
        errorCmnd = '';
      }
    }
    if (type == 'email') {
      email = value;
      validateEmail(email);
    }
    if (type == 'address') {
      address = value;
    }
    if (type == 'username') {
      username = value;
      if (username.isEmpty) {
        errorUsername = '';
      }
      if (username.isNotEmpty && username.contains(' ')) {
        errorUsername = 'Tên tài khoản không chứa khoảng trắng!';
      } else {
        errorUsername = '';
      }
    }
    if (type == 'password') {
      password = value;
      validatePass(password);
    }
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
    notifyListeners();
  }

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
    notifyListeners();
  }

  void showPass() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void selectPhongBan() {
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 300,
            decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView.builder(
                itemCount: lstPhongban.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      lstPhongban[index].name,
                      style: const TextStyle(
                          color: AppColors.textBlack, fontSize: 15),
                    ),
                    onTap: () {
                      phongban = lstPhongban[index];
                      notifyListeners();
                      Navigator.pop(context);
                    },
                  );
                }),
          );
        });
  }

  void selectChucVu() {
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 300,
            decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView.builder(
                itemCount: lstChucvu.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      lstChucvu[index].name,
                      style: const TextStyle(
                          color: AppColors.textBlack, fontSize: 15),
                    ),
                    onTap: () {
                      chucvu = lstChucvu[index];
                      notifyListeners();
                      Navigator.pop(context);
                    },
                  );
                }),
          );
        });
  }
}
