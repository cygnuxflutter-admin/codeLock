import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';

class SubCategoryData {
  final AppDataBase _appDataBase = AppDataBase();
  String catId;
  String subId;
  int subFieldType;
  String subName;
  int isMandatory;

  SubCategoryData({
    required this.catId,
    required this.subId,
    required this.subFieldType,
    required this.subName,
    required this.isMandatory,
  });

  Map<String, dynamic> toMap() {
    return {
      'CAT_ID': catId,
      'SUB_ID': subId,
      'SUB_FIELD_TYPE': subFieldType,
      'SUB_NAME': subName,
      'IS_MANDATORY': isMandatory,
    };
  }

  void insertSubCatData() async {
    Map<String, dynamic> data = toMap();
    await _appDataBase.insert(data, Tables.subCat).then((value) {
      // Data inserted
    });
  }
}
