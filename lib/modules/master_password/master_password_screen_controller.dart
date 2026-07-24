import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/custom/timer_method.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:code_lock/widget/code_lock_tost.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class MasterPasswordScreenController extends GetxController {
  TextEditingController password = TextEditingController();
  String? login = LocalData.getPasswordData;

  SingletonTimer time = SingletonTimer();

  passwordToast(BuildContext context) {
    if (password.text.isEmpty) {
      CodeLockToast(context, text: allLanguages!.entersomething);
    } else if (password.text == LocalData.getPasswordData) {
      Get.offAllNamed(AppRoutes.HomeScreen);
      time.startTimer();
    } else {
      CodeLockToast(context, text: allLanguages!.wrongpassword);
    }
  }

  passCodeToast(BuildContext context) {
    if (CodeLockString.pas3.isEmpty) {
      CodeLockToast(context, text: allLanguages!.entersomething);
    } else if (CodeLockString.pas3 == LocalData.getPasswordData) {
      CodeLockString.pas3 = '';
      time.startTimer();
      Get.offAllNamed(AppRoutes.HomeScreen);
    } else {
      CodeLockToast(context, text: allLanguages!.wrongpassword);
    }
  }
}
