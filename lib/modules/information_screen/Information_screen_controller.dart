import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/models/get_database/get_titles.dart';
import 'package:get/get.dart';

enum Status { loading, done, error }

class InformationScreenController extends GetxController {
  final AppDataBase _appDataBase = AppDataBase();

  List<TitleModel> titles = [];

  List<TitleModel> dataIn = <TitleModel>[];

  String? catIdData;

  Rx<Status> status = Status.loading.obs;

  @override
  void onInit() {
    getTitleData();
    super.onInit();
  }

  int _retryCount = 0;
  void getTitleData() {
    Map<String, dynamic> args = Get.arguments;
    catIdData = args['catId'];
    _changeStatus(Status.loading);
    _appDataBase.query(Tables.titles).then((value) {
      titles = value.map((map) => TitleModel.fromMap(map)).toList();
      _changeStatus(Status.done);
      _retryCount = 0;
    }).catchError((error, stackTrace) {
      if (_retryCount < 2) {
        _retryCount++;
        Future.delayed(const Duration(milliseconds: 300), () => getTitleData());
      } else {
        print("Error in Information getTitleData: $error");
        _changeStatus(Status.error);
        _retryCount = 0;
      }
    });
  }

  List<TitleModel> getTitleDataContain() {
    dataIn = titles.where((title) => title.catId == catIdData).toList();
    return dataIn;
  }

  _changeStatus(Status value) => status(value);
}
