import 'dart:async';
import 'dart:io';

import 'dart:ui';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:flutter/material.dart';
import 'package:code_lock/backup/google_drive_back_up.dart';
import 'package:code_lock/custom/timer_method.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:path_provider/path_provider.dart';

class SettingScreenController extends GetxController {
  RxDouble timer = 0.0.obs;
  SingletonTimer time = SingletonTimer();
  double value = 0;

  StreamController<List<File>> streamFiles = StreamController<List<File>>();

  final DriveBackUP drive = DriveBackUP();

  void _showLoadingDialog(String message) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: CodeLockColor.glassBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: CodeLockColor.glassBorder, width: 1.2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: CodeLockColor.accentVibrant),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void backUp() {
    _showLoadingDialog("Backing up your data...\nPlease wait.");
    drive.backup(
      done: () {
        Logger().i("================ BACKUP SUCCESSFUL ================");
        Get.back(); // close loading dialog
        Get.snackbar("Backup", "Success", colorText: Colors.white, backgroundColor: CodeLockColor.green.withOpacity(0.8));
        getAllBackUp();
      },
      error: (err) {
        Logger().e("================ BACKUP FAILED: $err ================");
        Get.back(); // close loading dialog
        Get.snackbar("Backup Failed", "$err", colorText: Colors.white, backgroundColor: Colors.redAccent.withOpacity(0.8));
      },
    );
  }

  void restore(String id) async {
    _showLoadingDialog("Restoring your data...\nPlease wait.");
    drive.restore(
      id: id,
      done: () {
        Logger().i("================ RESTORE SUCCESSFUL ================");
        Get.back(); // close loading dialog
        Get.snackbar("Restore", "Success", colorText: Colors.white, backgroundColor: CodeLockColor.green.withOpacity(0.8));
        Future.delayed(const Duration(seconds: 1), () {
          SystemNavigator.pop();
          Future.delayed(const Duration(seconds: 1), () {
            exit(0);
          });
        });
      },
    );
  }

  Future<void> getAllBackUp() async {
    if (streamFiles.isClosed) {
      streamFiles = StreamController<List<File>>();
    }
    final data = await drive.getAll();
    streamFiles.sink.add(data);
  }

  void deleteBackUp(String id) async {
    _showLoadingDialog("Deleting backup...\nPlease wait.");
    try {
      await drive.deleteFile(id);
      await getAllBackUp();
      Get.back(); // close loading dialog
      Get.snackbar("Backup Deleted", "Success", colorText: Colors.white, backgroundColor: CodeLockColor.green.withOpacity(0.8));
    } catch (err) {
      Get.back(); // close loading dialog
      Get.snackbar("Delete Failed", "$err", colorText: Colors.white, backgroundColor: Colors.redAccent.withOpacity(0.8));
    }
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
