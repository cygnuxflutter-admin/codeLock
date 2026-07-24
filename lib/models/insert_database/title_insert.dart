import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';

class TitleData {
  final AppDataBase _appDataBase = AppDataBase();

  String catId;
  String titleId;
  String titleName;
  int openedCount;

  TitleData({
    required this.catId,
    required this.titleId,
    required this.titleName,
    required this.openedCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'CAT_ID': catId,
      'TITLE_ID': titleId,
      'TITLE_NAME': titleName,
      'OPENED_COUNT': openedCount,
    };
  }

  void insertTitleData() async {
    Map<String, dynamic> data = toMap();
    await _appDataBase.insert(data, Tables.titles).then((value) {
      // Data inserted successfully
    });
  }
}
