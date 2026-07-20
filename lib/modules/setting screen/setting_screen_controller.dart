import 'dart:async';
import 'dart:io';

import 'package:code_lock/backup/google_drive_back_up.dart';
import 'package:code_lock/custom/timer_method.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:path_provider/path_provider.dart';

class SettingScreenController extends GetxController {
  RxDouble timer = 0.0.obs;
  SingletonTimer time = SingletonTimer();
  double value = 0;

  StreamController<List<File>> streamFiles = StreamController<List<File>>();

  final DriveBackUP drive = DriveBackUP();

  void backUp() {
    drive.backup(
      done: () {
        Get.snackbar("Backup", "Success");
        getAllBackUp();
      },
      error: (err) => Get.snackbar("Backup", "$err"),
    );
  }

  void restore(String id) async {
    drive.restore(
      id: id,
      done: () {
        Get.snackbar("Backup", "Success");
        Future.delayed(const Duration(seconds: 1), () {
          SystemNavigator.pop();
          Future.delayed(const Duration(seconds: 1), () {
            exit(0);
          });
        });
      },
    );
  }

  void getAllBackUp() async {
    if (streamFiles.isClosed) {
      streamFiles = StreamController<List<File>>();
    }
    final data = await drive.getAll();
    streamFiles.sink.add(data);
  }

  void deleteBackUp(String id) async {
    await drive.deleteFile(id).then((value) {
      getAllBackUp();
    });
  }

  @override
  void dispose() {
    streamFiles.close();
    super.dispose();
  }

  void close() {
    streamFiles.close();
  }
}

// Future<void> clearImageFolder() async {
//   final Directory appDir = await getApplicationDocumentsDirectory();
//   final String folderPath = '${appDir.path}/app_data';
//   final Directory folder = Directory(folderPath);
//   if (await folder.exists()) {
//     List<FileSystemEntity> files = folder.listSync(recursive: false);
//     for (FileSystemEntity file in files) {
//       if (file is File) {
//         await file.delete();
//       }
//     }
//   }
// }

Future<void> clearImageFolder() async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String folderPath = '${appDir.path}/app_data';
  final Directory folder = Directory(folderPath);
print("*****************************************************");
  if (await folder.exists()) {
    List<FileSystemEntity> files = folder.listSync(recursive: false);
    for (FileSystemEntity file in files) {
      if (file is File ||
          (file.path.endsWith('.jpg') ||
              file.path.endsWith('.png') ||
              file.path.endsWith('.jpeg') ||
              file.path.endsWith('.svg'))) {
        print("images deleted");
        // Add additional image file extensions if needed (e.g., '.png', '.jpeg')
        await file.delete();
      }
    }
  }else{
    print("folder doesn't exist");
  }
}
