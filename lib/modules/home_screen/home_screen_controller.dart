import 'dart:async';
import 'dart:io';
import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/models/get_database/get_catmain.dart';
import 'package:code_lock/models/get_database/get_titles.dart';
import 'package:code_lock/modules/information_screen/Information_screen_controller.dart';
import 'package:get/get.dart';
import 'package:code_lock/models/languages.dart';
import 'package:code_lock/custom/timer_method.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:path_provider/path_provider.dart';

enum Status { loading, done, error }

class HomeScreenController extends GetxController {
  InformationScreenController infoController = InformationScreenController();

  Languages? languages;

  final SingletonTimer time = SingletonTimer();

  final AppDataBase _appDataBase = AppDataBase();

  List<CatMainModel> catMainTable = [];

  List<TitleModel> titles = [];

  List<TitleModel> dataIn = <TitleModel>[];

  StreamController<List<CatMainModel>> catMainTableStreamController = StreamController<List<CatMainModel>>.broadcast();


  Rx<Status> status = Status.loading.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    await createFolder();
    await getTitleData();
    await getCatMainData();
    if (status.value != Status.error) {
      _changeStatus(Status.done);
    }
  }

  Future<void> createFolder() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String folderPath = '${appDir.path}/app_data';
    Directory(folderPath).create(recursive: true);
  }

  int _retryCatCount = 0;
  Future<void> getCatMainData() async {
    await _appDataBase.query(Tables.catMain).then((value) {
      catMainTable = value.map((map) => CatMainModel.fromMap(map)).toList();
      catMainTable.sort((a, b) {
        int aCount = int.tryParse(a.openedCount ?? '0') ?? 0;
        int bCount = int.tryParse(b.openedCount ?? '0') ?? 0;
        return bCount.compareTo(aCount);
      });
      catMainTableStreamController.add(catMainTable);
      _changeStatus(Status.done); // Recover from error state
      _retryCatCount = 0;
    }).catchError((error, stackTrace) {
      if (_retryCatCount < 2) {
        _retryCatCount++;
        Future.delayed(const Duration(milliseconds: 300), () => getCatMainData());
      } else {
        print("Error in getCatMainData: $error");
        print(stackTrace);
        _changeStatus(Status.error);
        _retryCatCount = 0;
      }
    });
  }

  int _retryTitleCount = 0;
  Future<void> getTitleData() async {
    await _appDataBase.query(Tables.titles).then((value) {
      titles = value.map((map) => TitleModel.fromMap(map)).toList();
      catMainTableStreamController.add(catMainTable);
      _changeStatus(Status.done); // Recover from error state
      _retryTitleCount = 0;
    }).catchError((error, stackTrace) {
      if (_retryTitleCount < 2) {
        _retryTitleCount++;
        Future.delayed(const Duration(milliseconds: 300), () => getTitleData());
      } else {
        print("Error in getTitleData: $error");
        print(stackTrace);
        _changeStatus(Status.error);
        _retryTitleCount = 0;
      }
    });
  }

  List<TitleModel> getTitleDataContain(String catIdData) {
    dataIn = titles.where((title) => title.catId == catIdData).toList();
    return dataIn;
  }

  void _changeStatus(Status value) {
    status.value = value;
  }
}

listOfIcon(iconList) {
  switch (iconList) {
    case 'i1':
      return CodeLockImages.bank;
    case 'i2':
      return CodeLockImages.car;
    case 'i3':
      return CodeLockImages.insurance;
    case 'i4':
      return CodeLockImages.computer;
    case 'i5':
      return CodeLockImages.credit_cards;
    case 'i6':
      return CodeLockImages.logins;
    case 'i7':
      return CodeLockImages.logins;
    case 'i8':
      return CodeLockImages.Email_acc;
    case 'i9':
      return CodeLockImages.license;
    default:
      return CodeLockImages.bank;
  }
}
