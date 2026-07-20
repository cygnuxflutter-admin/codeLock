import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/widget/code_lock_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'field_screen.dart';

class FieldScreenController extends GetxController {
  TextEditingController groupName = TextEditingController();

  int totalTextField = 0;

  int selected_keyboard = 0;

  RxBool canInsert = RxBool(true);

  List<CustomFieldController> multipleField = [];

  final RxInt Index = 0.obs;

  RxList<String> images = [
    CodeLockImages.bank,
    CodeLockImages.car,
    CodeLockImages.insurance,
    CodeLockImages.computer,
    CodeLockImages.credit_cards,
    CodeLockImages.logins,
    CodeLockImages.Email_acc,
    CodeLockImages.license,
  ].obs;

  List<String> samples = [
    "123",
    "ABC-XYZ",
    "***********",
    "YES/NO",
    "+1-541-754-3010",
    "IMAGE",
    "12-DEC-1995",
    "12:55 AM",
  ];

  String getReturnValue(index) {
    String imagePath = images[index];
    switch (imagePath) {
      case CodeLockImages.bank:
        return "i1";
      case CodeLockImages.car:
        return "i2";
      case CodeLockImages.insurance:
        return "i3";
      case CodeLockImages.computer:
        return "i4";
      case CodeLockImages.credit_cards:
        return "i5";
      case CodeLockImages.logins:
        return "i6";
      case CodeLockImages.Email_acc:
        return "i7";
      case CodeLockImages.license:
        return "i8";
      default:
        return "i1";
    }
  }

  index(BuildContext context) {
    if (Index == 0) {
      Index.value = 6;
    } else {
      Index.value -= 1;
    }
  }

  index1(BuildContext context) {
    if (Index == 6) {
      Index.value = 0;
    } else {
      Index.value += 1;
    }
  }

  fieldoast(BuildContext context) {
    if (groupName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar(
          context: context,
          msg: "Please Enter Group Name",
          textStyle: TextStyle(
            color: CodeLockColor.homelist,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      Get.toNamed(AppRoutes.HomeScreen);
    }
  }
}
