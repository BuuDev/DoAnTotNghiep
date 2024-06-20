part of 'add_new_contract.dart';

class AddNewContractLogic extends ChangeNotifier {
  late BuildContext context;
  AddNewContractLogic({required this.context}) {
    getListDepartmentAndListRoles();
  }

  late final TextEditingController txtPassword = TextEditingController();
  List<RoleUser> lstChucVu = [];
  List<Department> lstPhongban = [];
  DemoService service = DemoService.client();
  ContractService contractService = ContractService.client();
  SalaryService salaryService = SalaryService.client(isLoading: false);
  void getListDepartmentAndListRoles() async {
    try {
      await service.getListUser().then((value) {
        lstPhongban = value.department;
        lstChucVu = value.role;
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  String name = '';
  String username = '';
  String password = '';
  String email = '';
  String address = '';
  String phone = '';
  String cmnd = '';
  String content = '';
  String salary = '';
  RoleUser chucvu = RoleUser(id: 0, name: '');
  Department phongban = Department(id: 0, name: '');
  String typeSalary = '';
  String birthday = '2004-01-01';
  String errorEmail = '';
  String startDay = 'dd/ mm/ yyyy';
  String endDay = 'dd/ mm/ yyyy';
  String day = 'dd/ mm/ yyyy';
  String errorPassword = '';
  bool showPassword = false;

  void addNewContract() async {
    await contractService
        .createNewContract(
            name,
            username,
            password,
            birthday,
            phone,
            address,
            cmnd,
            email,
            content,
            salary,
            chucvu.id.toString(),
            phongban.id.toString(),
            startDay,
            endDay,
            day)
        .then((value) async {
      NotifyHelper.showSnackBar(value.message);
      if (value.message == 'Thêm thành công') {
        await salaryService
            .getSalary(DateFormat('yyyy-MM').format(DateTime.now()));
        Navigator.pop(context, true);
      }
    });
  }

  void updateValue(String type, String value) {
    if (type == 'name') {
      name = value;
    }
    if (type == 'username') {
      username = value;
    }
    if (type == 'password') {
      password = value;
    }
    if (type == 'email') {
      email = value;
    }
    if (type == 'address') {
      address = value;
    }
    if (type == 'phone') {
      phone = value;
    }
    if (type == 'cmnd') {
      cmnd = value;
    }
    if (type == 'content') {
      content = value;
    }
    if (type == 'salary') {
      salary = value;
    }
    notifyListeners();
  }

  void selectChucvu() {
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
                itemCount: lstChucVu.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      lstChucVu[index].name,
                      style: const TextStyle(
                          color: AppColors.textBlack, fontSize: 15),
                    ),
                    onTap: () {
                      chucvu = lstChucVu[index];
                      notifyListeners();
                      Navigator.pop(context);
                    },
                  );
                }),
          );
        });
  }

  void selectPhongban() {
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

  void updateBirthday(value) {
    if (value != null) {
      birthday = DateFormat('yyyy-MM-dd').format(value);
    }
    notifyListeners();
  }

  void updateStartDay(value1, {value2}) {
    try {
      if (value1 != null) {
        startDay = DateFormat('yyyy-MM-dd 00:00:00').format(value1);
        endDay = DateFormat('yyyy-MM-dd 00:00:00').format(value2);
      }
    } catch (e) {
      if (value1 != null) {
        startDay =
            DateFormat('yyyy-MM-dd 00:00:00').format(DateTime.parse(value1));
        endDay =
            DateFormat('yyyy-MM-dd 00:00:00').format(DateTime.parse(value2));
      }
    }
    notifyListeners();
  }

  void updateEndDay(value) {
    try {
      if (value != null) {
        endDay = DateFormat('yyyy-MM-dd 00:00:00').format(value);
      }
    } catch (e) {
      if (value != null) {
        endDay =
            DateFormat('yyyy-MM-dd 00:00:00').format(DateTime.parse(value));
      }
    }
    notifyListeners();
  }

  void updateDay(value) {
    if (value != null) {
      day = DateFormat('yyyy-MM-dd').format(value);
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
}

enum selectNV { newEmployee, oldEmployee }
