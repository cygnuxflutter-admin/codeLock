import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/custom/timer_method.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:code_lock/widget/code_lock_tost.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class StartScreenController extends GetxController {
  int? passcode;

  OtpFieldController otpController1 = OtpFieldController();

  OtpFieldController otpController2 = OtpFieldController();

  TextEditingController otp1 = TextEditingController();

  TextEditingController otp2 = TextEditingController();

  final SingletonTimer time = SingletonTimer();

  password(BuildContext context) {
    if (otp1.text.isEmpty || otp2.text.isEmpty) {
      CodeLockToast(context, text: allLanguages!.pleaseEnterValidPassword);
    } else if (otp1.text.length < 6 && otp2.text.length < 6) {
      CodeLockToast(context, text: CodeLockString.passLength6);
    } else if (otp1.text == otp2.text) {
      LocalData.setPasswordData(otp2.text);
      LocalData.setIsLogin(true);
      LocalData.setIsPass(true);
      Get.offAllNamed(AppRoutes.HomeScreen);
      time.startTimer();
      CodeLockToast(context, text: allLanguages!.login_successfully);
    } else {
      CodeLockToast(context, text: allLanguages!.passwordNotMatch);
      otp1.clear();
      otp2.clear();
    }
  }

  passCode(BuildContext context) {
    if (CodeLockString.pas.isEmpty || CodeLockString.pas2.isEmpty) {
      CodeLockToast(context, text: allLanguages!.plzenterpasscode);
    } else if (CodeLockString.pas2.length < 4 ||
        CodeLockString.pas.length < 4) {
      CodeLockToast(context, text: allLanguages!.passcodelenghthshouldbe4digit);
    } else if (CodeLockString.pas == CodeLockString.pas2) {
      LocalData.setPasswordData(CodeLockString.pas2);
      LocalData.setIsLogin(true);
      LocalData.setIsPass(false);
      Get.offAllNamed(AppRoutes.HomeScreen);
      time.startTimer();
      CodeLockToast(context, text: allLanguages!.login_successfully);
    } else {
      CodeLockToast(context, text: allLanguages!.passwordNotMatch);
      otpController1.clear();
      otpController2.clear();
    }
  }
}
