import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/custom/encryption_helper.dart';

class DescriptionData {
  final AppDataBase _appDataBase = AppDataBase();

  final String catId;
  final String subId;
  final String subName;
  final String subFieldType;
  final String titleId;
  final String titleName;
  final String valueId;
  final String value;

  DescriptionData({
    required this.catId,
    required this.subId,
    required this.subName,
    required this.subFieldType,
    required this.titleId,
    required this.titleName,
    required this.valueId,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'CAT_ID': catId,
      'SUB_ID': subId,
      'SUB_NAME': subName,
      'SUB_FIELD_TYPE': subFieldType,
      'TITLE_ID': titleId,
      'TITLE_NAME': titleName,
      'VALUE_ID': valueId,
      'VALUE': EncryptionHelper.encryptText(value),
    };
  }

  void insertDescriptionData() async {
    Map<String, dynamic> data = toMap();
    await _appDataBase.insert(data, Tables.descriptions).then((value) {
      // data inserted
    });
  }
}
