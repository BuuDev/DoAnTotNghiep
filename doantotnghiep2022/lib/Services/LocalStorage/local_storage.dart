import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._();
  SharedPreferences? _pref;

  SharedPreferences get store => _pref!;

  LocalStorage._();

  factory LocalStorage() => _instance;

  static LocalStorage get instance => _instance;

  static Future<void> init() async {
    instance._pref ??= await SharedPreferences.getInstance();
    return Future.value();
  }

  // SharedPreferences? _pref;

  // Future<void> init() async {
  //   _pref ??= await SharedPreferences.getInstance();
  //   return Future.value();
  // }

  //String get token => _pref!.getString('token') ?? 'abc';
  String get token => store.getString('token') ?? '';
  // Future<bool> setToken(String key, String token) async {
  //   await init();
  //   return _pref!.setString(key, token);
  // }

  // Future<String> getString(String key) async {
  //   await init();
  //   return _pref!.getString(key) ?? 'error';
  // }
  setToken(String key, String token) {
    return store.setString(key, token);
  }

  String? getString(String key) {
    return store.getString(key);
  }
}
