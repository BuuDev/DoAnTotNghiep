part of 'account.dart';

class AccountLogic extends ChangeNotifier {
  AccountLogic() {
    //getProvince();
    //fillData();
  }
  // ProvinceService service = ProvinceService(Dio(),
  //     baseUrl: 'https://sheltered-anchorage-60344.herokuapp.com/');

  List<Province> data = [];
  List<Province> dataSearch = [];
  String name = '';
  String birthday = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String cmnd = '';
  String email = '';
  String phone = '';
  String address = '';
  String username = '';
  int? departmentId;
  int? roleId;
  TextEditingController txtSearch = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  UserDemo? user;
  bool activeButton = false;
  DemoService service = DemoService.client();

  final ImagePicker picker = ImagePicker();
  XFile? image;
  File? imageShow;
  // void getProvince() async {
  //   if (data.isEmpty) {
  //     try {
  //       data = await service.getProvince();
  //       dataSearch = data;
  //     } catch (e) {
  //       debugPrint('$e');
  //     }
  //   }
  //   notifyListeners();
  // }

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
    updateValueTextfield('', '');
    notifyListeners();
  }

  void fillData() async {
    await Future.delayed(const Duration(milliseconds: 500), () {})
        .then((value) {});
    UserDemo? getDataFromLocalStorage =
        UserDemo.fromJson(jsonDecode(LocalStorage().getString('userData')!));
    if (LocalStorage().getString('userData')!.isNotEmpty) {
      user = UserDemo(
        email: getDataFromLocalStorage.email,
        avatar: getDataFromLocalStorage.avatar,
        id: getDataFromLocalStorage.id,
        fullname: getDataFromLocalStorage.fullname,
        address: getDataFromLocalStorage.address,
        birthday: getDataFromLocalStorage.birthday,
        citizenIdentification: getDataFromLocalStorage.citizenIdentification,
        code: getDataFromLocalStorage.code,
        departmentId: getDataFromLocalStorage.departmentId,
        phone: getDataFromLocalStorage.phone,
        roleId: getDataFromLocalStorage.roleId,
        username: getDataFromLocalStorage.username,
      );
      name = getDataFromLocalStorage.fullname!;
      birthday = getDataFromLocalStorage.birthday!;
      phone = getDataFromLocalStorage.phone!;
      cmnd = getDataFromLocalStorage.citizenIdentification!;
      email = getDataFromLocalStorage.email!;
      address = getDataFromLocalStorage.address!;
      username = getDataFromLocalStorage.username!;
      departmentId = getDataFromLocalStorage.departmentId;
      roleId = getDataFromLocalStorage.roleId;
    }
    notifyListeners();
  }

  void updateBirthday(value) {
    if (value != null) {
      birthday = DateFormat('yyyy-MM-dd').format(value);
    }
    updateValueTextfield('', '');
    notifyListeners();
  }

  void logout(BuildContext context) async {
    try {
      customLoading(context);
      await LocalStorage().store.setString('userData', '');
      await LocalStorage().store.setString('token', '');
      user = null;
      imageShow = null;
      Navigator.pushNamedAndRemoveUntil(
          context, Routes().login, (route) => true);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updateValueTextfield(String type, String value) {
    if (type == 'name') {
      name = value;
    }
    if (type == 'phone') {
      phone = value;
    }
    if (type == 'cmnd') {
      cmnd = value;
    }
    if (type == 'email') {
      email = value;
    }
    if (type == 'address') {
      address = value;
    }
    if (name == user!.fullname &&
        birthday == user!.birthday &&
        phone == user!.phone &&
        cmnd == user!.citizenIdentification &&
        email == user!.email &&
        address == user!.address &&
        imageShow == null) {
      activeButton = false;
    } else {
      activeButton = true;
    }
    notifyListeners();
  }

  void updateInfoUser() async {
    await service
        .updateInfoUser(name, username, birthday, phone, address, cmnd, email,
            roleId!, departmentId!, imageShow)
        .then((value) {
      NotifyHelper.showSnackBar(value.message);
    });
  }
}
