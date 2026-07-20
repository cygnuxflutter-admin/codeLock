import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> deleteFiles() async {
  final appDir = await getApplicationDocumentsDirectory();
  final zipFilePath = '${appDir.path}/backup.zip';
  // final folderPath = '${appDir.path}/app_data/';
  final restoreZipFilePath = '${appDir.path}/restore.zip';

  final zipFile = File(zipFilePath);
  // final folderDir = Directory(folderPath);
  final sqliteFile = File(restoreZipFilePath);

  if (zipFile.existsSync()) {
    await zipFile.delete();
    print('Zip file deleted.');
  } else {
    print('Zip file does not exist.');
  }

  // if (folderDir.existsSync()) {
  //   await folderDir.delete(recursive: true);
  //   print('Folder deleted.');
  // } else {
  //   print('Folder does not exist.');
  // }

  if (sqliteFile.existsSync()) {
    await sqliteFile.delete();
    print('restoreZip file deleted.');
  } else {
    print('restoreZip file does not exist.');
  }
}

// void main() async {
//   await deleteFiles();
// }
