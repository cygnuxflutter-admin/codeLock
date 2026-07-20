import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';

class CatMainData {
  final AppDataBase _appDataBase = AppDataBase();
  String catId;
  String catName;
  String catImg;
  int openedCount;

  CatMainData({
    required this.catId,
    required this.catName,
    required this.catImg,
    required this.openedCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'CAT_ID': catId,
      'CAT_NAME': catName,
      'CAT_IMG': catImg,
      'OPENED_COUNT': openedCount,
    };
  }

  void insertCatMainData() async {
    Map<String, dynamic> data = toMap();
    await _appDataBase.insert(data, Tables.catMain).then((value) {
      // data inserted
    });
  }
}
