part of 'add_new_contract_personal.dart';

class AddNewContractPersonalLogic extends ChangeNotifier {
  late BuildContext context;
  AddNewContractPersonalLogic({required this.context});
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtCMND = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtNewEmployeeName = TextEditingController();
  late final TextEditingController txtPassword = TextEditingController();
  TextEditingController txtContent = TextEditingController();
  TextEditingController txtSalary = TextEditingController();
  String content = '';
  String salary = '';
  ContractService service = ContractService.client();
  SalaryService service2 = SalaryService.client(isLoading: false);

  void updateValue(String type, String value) {
    if (type == 'content') {
      content = value;
    }
    if (type == 'salary') {
      salary = value;
    }
    notifyListeners();
  }

  void updateContract(int id, int userId) async {
    await service
        .updateContract(
            id, userId.toString(), content, salary, startDay, endDay, day)
        .then((value) async {
      NotifyHelper.showSnackBar(value.message);
      await service2.getSalary(DateFormat('yyyy-MM').format(DateTime.now()));
      Navigator.pop(context, true);
    });
  }

  void extendContract(int id, int userId) async {
    await service
        .giaHanContract(
            userId.toString(), content, salary, startDay, endDay, day)
        .then((value) async {
      NotifyHelper.showSnackBar(value.message);
      await service2.getSalary(DateFormat('yyyy-MM').format(DateTime.now()));
      Navigator.pop(context, true);
    });
  }

  List lstNV = [
    {
      'id': 1,
      'name': 'Tống Thành Tài',
    },
    {
      'id': 2,
      'name': 'Trần Đức Anh Tú',
    },
    {
      'id': 3,
      'name': 'Phùng Khả Hào',
    },
    {
      'id': 4,
      'name': 'Nguyễn Hồ Xuân Nguyên',
    },
    {
      'id': 5,
      'name': 'Bùi Tuấn Anh',
    }
  ];

  List lstChucVu = [
    {
      'id': 1,
      'chucvu': 'Giám đốc',
    },
    {
      'id': 2,
      'chucvu': 'Trưởng phòng',
    },
    {
      'id': 3,
      'chucvu': 'Nhân viên',
    },
    {
      'id': 4,
      'chucvu': 'admin',
    }
  ];

  List lstPhongban = [
    {
      'id': 1,
      'phongban': 'Phòng nhân sự',
    },
    {
      'id': 2,
      'phongban': 'Phòng marketing',
    },
    {
      'id': 3,
      'phongban': 'Phòng IT',
    },
  ];
  dynamic name = '';
  dynamic chucvu = '';
  dynamic phongban = '';
  String typeSalary = '';
  String birthday = DateFormat('dd/ MM/ yyyy').format(DateTime.now());
  String errorEmail = '';
  String startDay = 'dd/ mm/ yyyy';
  String endDay = 'dd/ mm/ yyyy';
  String day = 'dd/ mm/ yyyy';
  String errorPassword = '';
  bool showPassword = false;
  void selectNhanvien() {
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
                itemCount: lstNV.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      lstNV[index]['name'],
                      style: const TextStyle(
                          color: AppColors.textBlack, fontSize: 15),
                    ),
                    onTap: () {
                      name = lstNV[index];
                      notifyListeners();
                      Navigator.pop(context);
                    },
                  );
                }),
          );
        });
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
                      lstChucVu[index]['chucvu'],
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
                      lstPhongban[index]['phongban'],
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

  // void updateStartDay(value) {
  //   if (value != null) {
  //     startDay = DateFormat('yyyy-MM-dd').format(value);
  //   }
  //   notifyListeners();
  // }

  // void updateEndDay(value) {
  //   if (value != null) {
  //     endDay = DateFormat('yyyy-MM-dd').format(value);
  //   }
  //   notifyListeners();
  // }

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
    try {
      if (value != null) {
        day = DateFormat('yyyy-MM-dd 00:00:00').format(value);
      }
    } catch (e) {
      if (value != null) {
        day = DateFormat('yyyy-MM-dd 00:00:00').format(DateTime.parse(value));
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
    txtEmail.text = email;
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

  void updateNameNewEmployee(value) {
    txtNewEmployeeName.text = value;
    notifyListeners();
  }
}

enum selectNV { newEmployee, oldEmployee }
