import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  LocalData._internal();

  static late SharedPreferences _sharedPreferences;
  static Future<SharedPreferences> init() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  static setPasswordData(String? value) async =>
      await _sharedPreferences.setString(SharedKey.password, value ?? '');

  static setLanguage(String? value) async =>
      await _sharedPreferences.setString(SharedKey.language, value ?? '');

  static setIsLogin(bool isLogin) async {
    await _sharedPreferences.setBool(SharedKey.isLogin, isLogin);
  }

  static setIsPass(bool pass) async {
    await _sharedPreferences.setBool(SharedKey.pass, pass);
  }

  static setIsSec(double sec) async {
    await _sharedPreferences.setDouble(SharedKey.sec, sec);
  }

  static String? get getLanguage =>
      _sharedPreferences.getString(SharedKey.language) ?? 'English';

  static String? get getPasswordData =>
      _sharedPreferences.getString(SharedKey.password) ?? '';
  static bool? get getIsLogin =>
      _sharedPreferences.getBool(SharedKey.isLogin) ?? false;
  static bool? get getIsPass =>
      _sharedPreferences.getBool(SharedKey.pass) ?? false;
  static get getIsSec => _sharedPreferences.getDouble(SharedKey.sec) ?? 20;

  static Future<bool>? clear() {
    if (_sharedPreferences == null) return null;
    return _sharedPreferences.clear();
  }
}

class SharedKey {
  static String password = "password";
  static String isLogin = "isLogin";
  static String pass = "pass";
  static String sec = 'sec';
  static String language = 'language';
}
