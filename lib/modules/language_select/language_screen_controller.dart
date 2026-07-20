import 'package:code_lock/custom/timer_method.dart';
import 'package:code_lock/models/languages.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Languages? languages;

AllLanguages? allLanguages;

class LanguageScreenController extends GetxController {
  String? selectedValue;

  String selectedLanguage = '';

  RxList<String> language = ["English", "French", "Hindi", "Spanish", "German"].obs;

  bool showList = true;

  SingletonTimer time = SingletonTimer();

  Future<String> readJsonData(String filePath) async {
    return await rootBundle.loadString(filePath);
  }

  getLanguages() async {
    String jsonData = await readJsonData('assets/languages/languages.json');
    languages =  languagesFromJson(jsonData);
    allLanguages = languages!.locker.allLanguages;
    // return languagesFromJson(jsonData);
  }

  languagechange(BuildContext context ,  int index) {
    if (language[index] ==
        'English') {
      LocalData.setLanguage('English');
      LanguageScreenController().getLanguages();
    } else if (
        language[index] ==
        'French') {
      LocalData.setLanguage('French');
      LanguageScreenController().getLanguages();
    } else if (
       language[index] ==
        'Hindi') {
      LocalData.setLanguage('Hindi');
      LanguageScreenController().getLanguages();
    } else if (
        language[index] ==
        'Spanish') {
      LocalData.setLanguage('Spanish');
      LanguageScreenController().getLanguages();
    } else {
      LocalData.setLanguage('German');
      LanguageScreenController().getLanguages();
    }
  }
}
