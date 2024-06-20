part of 'auth_loading.dart';

class AuthLogic with ChangeNotifier {
  late BuildContext context;

  AuthLogic({required this.context}) {
    middleWare();
  }

  void middleWare() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? token = await sharedPreferences.getString("token");
    notifyListeners();
    Future.delayed(Duration(seconds: 2), () {
      if (token != "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const MyApp(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const Login(),
          ),
        );
      }
    });
    notifyListeners();
  }
}
