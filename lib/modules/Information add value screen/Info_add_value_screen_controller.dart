import 'dart:io';
import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:code_lock/models/get%20Database/get_subcat.dart';
import 'package:get/get.dart';

enum Status { loading, done, error }

class InfoAddValueScreenController extends GetxController {
  TextEditingController titleController = TextEditingController();

  final AppDataBase _appDataBase = AppDataBase();

  List<SubCat> subCatTable = [];

  String? catIdData;

  RxBool canInsert = RxBool(true);

  List<SubCat> dataIn = <SubCat>[];

  Rx<Status> status = Status.loading.obs;

  File? newFileName;

  String? imgName;


  @override
  void onInit() {
    getsubCatData();
    super.onInit();
  }

  void getsubCatData() {
    catIdData = Get.arguments;
    _appDataBase.query(Tables.subCat).then((value) {
      subCatTable = value.map((map) => SubCat.fromMap(map)).toList();
      getsubDataContain();
      _changeStatus(Status.done);
    }).onError((error, stackTrace) => _changeStatus(Status.error));
  }

  List<SubCat> getsubDataContain() {
    dataIn =
        subCatTable.where((element) => element.catId == catIdData).toList();

    for (SubCat element in dataIn) {
      element.controller = TextEditingController();
    }

    return dataIn;
  }

  _changeStatus(Status value) => status(value);
}

keyboardType(index) {
  switch (index) {
    case '0':
      return TextInputType.number;
    case '1':
      return TextInputType.text;
    case '2':
      return 'Password';
    case '3':
      return 'CheckBox'; //TextInputType.text;
    case '4':
      return TextInputType.phone;
    case '5':
      return 'ImagePicker';
    case '6':
      return 'DatePicker';
    case '7':
      return 'TimePicker';
  }
}

keyboardObSecure(index) {
  switch (index) {
    case '0':
      return false;
    case '1':
      return false;
    case '2':
      return true;
    case '3':
      return false;
    case '4':
      return false;
    case '5':
      return false;
    case '6':
      return false;
    case '7':
      return false;
  }
}
