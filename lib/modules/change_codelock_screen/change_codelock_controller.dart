import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:code_lock/widget/code_lock_tost.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeCodeLockScreenController extends GetxController {
  final GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyPasscode = GlobalKey<FormState>();

  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();

  password(BuildContext context) {
    if (formKeyPassword.currentState!.validate()) {
      LocalData.setPasswordData(otp5.text);
      Get.offAllNamed(AppRoutes.SettingScreen);
    }
  }

  newPasswordToast(BuildContext context) {
    if (formKeyPasscode.currentState!.validate()) {
      LocalData.setPasswordData(CodeLockString.pas6);
      Get.offAllNamed(AppRoutes.SettingScreen);
    }
  }
}
