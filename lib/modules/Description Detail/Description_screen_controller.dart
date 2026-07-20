import 'dart:io';

import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/models/get%20Database/get_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:code_lock/models/get%20Database/get_description.dart';
import 'package:get/get.dart';

enum Status { loading, done, error }

class DescriptionScreenController extends GetxController {
  Map<String, dynamic> args = Get.arguments;

  TextEditingController valueEdit = TextEditingController();

  TextEditingController titleEdit = TextEditingController();

  RxBool enable = RxBool(false);

  final AppDataBase _appDataBase = AppDataBase();

  List<DescriptionModel> description = [];

  List<TitleModel> titles = [];

  List<TitleModel> titleDataIn = <TitleModel>[];

  String? titleIdData;

  List<DescriptionModel> dataIn = <DescriptionModel>[];

  Rx<Status> status = Status.loading.obs;

  File? newFileName;

  String? newImageName;

  @override
  void onInit() {
    getTitleData();
    getDescriptionData();
    super.onInit();
    titleEdit = TextEditingController(text: args["titleName"].toString());
  }

  void getTitleData() {
    Map<String, dynamic> args = Get.arguments;
    titleIdData = args['titleId'];
    _appDataBase.query(Tables.titles).then((value) {
      titles = value.map((map) => TitleModel.fromMap(map)).toList();
      getTitleDataContain();
    }).onError((error, stackTrace) => _changeStatus(Status.error));
  }

  List<TitleModel> getTitleDataContain() {
    titleDataIn =
        titles.where((title) => title.titleId == titleIdData).toList();
    return titleDataIn;
  }

  void getDescriptionData() {
    titleIdData = args['titleId'];
    _appDataBase.query(Tables.descriptions).then((value) async {
      description = List<Map<String, dynamic>>.from(value)
          .map((map) => DescriptionModel.fromMap(map))
          .toList();
      getDescriptionDataContain();
      _changeStatus(Status.done);
    }).onError((error, stackTrace) => _changeStatus(Status.error));
  }

  List<DescriptionModel> getDescriptionDataContain() {
    dataIn =
        description.where((element) => element.titleId == titleIdData).toList();
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
      return 'CheckBox';
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