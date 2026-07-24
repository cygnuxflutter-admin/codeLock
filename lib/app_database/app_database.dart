import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper/database_helper.dart';
import 'helper/database_method_helper.dart';

class AppDataBase implements DBHelperMethod<Map<String, dynamic>> {
  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  @override
  Future<int> insert(Map<String, dynamic> data, String table) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    return dataBase.transaction(
      (txn) => txn.insert(
        table,
        data,
      ),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> query(String table) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    List<Map<String, dynamic>> userData = await dataBase.transaction(
      (txn) => txn.query(table),
    );
    return userData;
  }

  @override
  Future<int> delete(int data, String table) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    return dataBase.transaction(
      (txn) => txn.delete(
        table,
        where: ' = ?',
        whereArgs: [data],
      ),
    );
  }

  Future<int> deleteDatabase(String catId, String tableName) async {
    Database database = await _dataBaseHelper.dataBase;
    int rowsDeleted = await database.delete(
      tableName,
      where: 'CAT_ID = ?',
      whereArgs: [catId],
    );
    return rowsDeleted;
  }

  Future<int> deleteTitleDatabase(String catId, String tableName) async {
    Database database = await _dataBaseHelper.dataBase;
    int rowsDeleted = await database.delete(
      tableName,
      where: 'TITLE_ID = ?',
      whereArgs: [catId],
    );
    return rowsDeleted;
  }

  Future<int> deleteSubCat(String subId, String tableName) async {
    Database database = await _dataBaseHelper.dataBase;
    int rowsDeleted = await database.delete(
      tableName,
      where: 'SUB_ID = ?',
      whereArgs: [subId],
    );
    return rowsDeleted;
  }

  Future<int> updateCatMain(
      Map<String, dynamic> data, String table, String id) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    return dataBase.transaction(
      (txn) => txn.update(
        table,
        data,
        where: 'CAT_ID = ?',
        whereArgs: [id],
      ),
    );
  }

  Future<int> updateSubCat(
      Map<String, dynamic> data, String table, String id) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    return dataBase.transaction(
      (txn) => txn.update(
        table,
        data,
        where: 'SUB_ID = ?',
        whereArgs: [id],
      ),
    );
  }

  @override
  Future<int> update(Map<String, dynamic> data, String table) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    return dataBase.transaction(
      (txn) => txn.update(table, data),
    );
  }

  Future<int> updateTitle(
      Map<String, dynamic> data, String table, String id) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    return dataBase.transaction(
      (txn) => txn.update(
        table,
        data,
        where: 'TITLE_ID = ?',
        whereArgs: [id],
      ),
    );
  }

  Future<int> updateDescription(
      Map<String, dynamic> data, String table, String id) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    return dataBase.transaction(
      (txn) => txn.update(
        table,
        data,
        where: 'VALUE_ID = ?',
        whereArgs: [id],
      ),
    );
  }

  Future<int> updateCount(
      Map<String, dynamic> data, String table, String id) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    return dataBase.transaction(
      (txn) => txn.update(
        table,
        data,
        where: 'CAT_ID = ?',
        whereArgs: [id],
      ),
    );
  }

  Future<int> updateTitleCount(
      Map<String, dynamic> data, String table, String id) async {
    Database dataBase = await _dataBaseHelper.dataBase;
    return dataBase.transaction(
      (txn) => txn.update(
        table,
        data,
        where: 'TITLE_ID = ?',
        whereArgs: [id],
      ),
    );
  }

  Future<void> resetDataBase() async {
    Database dataBase = await _dataBaseHelper.dataBase;
    dataBase.delete(Tables.titles);
    dataBase.delete(Tables.catMain);
    dataBase.delete(Tables.descriptions);
    dataBase.delete(Tables.subCat);
    String catMain =
        await rootBundle.loadString("assets/default_data/CAT_MAIN.json");
    String subCait =
        await rootBundle.loadString("assets/default_data/SUB_CAT.json");

    List<dynamic> catTable = jsonDecode(catMain);
    List<dynamic> subTable = jsonDecode(subCait);
    for (var element in catTable) {
      await dataBase.insert(Tables.catMain, element);
    }

    for (var element in subTable) {
      await dataBase.insert(Tables.subCat, element);
    }
  }
}
