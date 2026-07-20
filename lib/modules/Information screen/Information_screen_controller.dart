import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/models/get%20Database/get_titles.dart';
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

  void getTitleData() {
    Map<String, dynamic> args = Get.arguments;
    catIdData = args['catId'];
    _appDataBase.query(Tables.titles).then((value) {
      titles = value.map((map) => TitleModel.fromMap(map)).toList();
      _changeStatus(Status.done);
    }).onError((error, stackTrace) => _changeStatus(Status.error));
  }

  List<TitleModel> getTitleDataContain() {
    dataIn = titles.where((title) => title.catId == catIdData).toList();
    return dataIn;
  }

  _changeStatus(Status value) => status(value);
}
