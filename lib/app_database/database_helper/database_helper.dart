import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class Tables {
  static const String titles = 'TITLES';
  static const String descriptions = 'DESCRIPTIONS';
  static const String subCat = 'SUB_CAT';
  static const String catMain = 'CAT_MAIN';
}

class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper _instance = DataBaseHelper._();

  factory DataBaseHelper() => _instance;

  Database? _database;

  Future<Database> get dataBase async => _database ??= await _initDataBase();

  void close(){
    _database?.close();
  }

  Future<Database> _initDataBase() async {
    try {
      Directory getDataBasesDir = await getApplicationDocumentsDirectory();
      String dataBasePath = join("${getDataBasesDir.path}/app_data", 'Pocket.sqlite');
      print("Database Path: $dataBasePath");
      
      if (!await databaseExists(dataBasePath)) {
        print("Database does not exist, copying from assets...");
        ByteData data = await rootBundle.load('assets/Pocket.sqlite');
        List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes,
          data.lengthInBytes,
        );
        await File(dataBasePath).writeAsBytes(bytes, flush: true);
        print("Database copied successfully.");
      } else {
        print("Database already exists.");
      }
      return openDatabase(dataBasePath);
    } catch (e) {
      print("Error initializing database: $e");
      rethrow;
    }
  }
}
