import 'dart:async';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:get/get.dart';

class SingletonTimer {
  static final SingletonTimer _singleton = SingletonTimer._internal();

  factory SingletonTimer() {
    return _singleton;
  }

  SingletonTimer._internal();

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: LocalData.getIsSec.toInt()), () {
      Get.offAllNamed(AppRoutes.MasterPassword);
    });
  }

  void resetTimer(int value) {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: value), () {
      Get.offAllNamed(AppRoutes.MasterPassword);
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
