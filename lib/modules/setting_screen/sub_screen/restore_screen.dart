import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/modules/setting_screen/setting_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:code_lock/widget/code_lock_alertdialogbox.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/widget/code_lock_empty_state.dart';
import 'package:code_lock/widget/code_lock_toast.dart';
class RestoreScreen extends StatefulWidget {
  const RestoreScreen({Key? key}) : super(key: key);

  @override
  State<RestoreScreen> createState() => _RestoreScreenState();
}

class _RestoreScreenState extends State<RestoreScreen> {
  final SettingScreenController controller =
      Get.find<SettingScreenController>();

  @override
  void initState() {
    controller.getAllBackUp();
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: ImageIcon(const AssetImage(CodeLockImages.back), size: 10, color: CodeLockColor.white),
            onTap: () {
              detectOnTap();
              Get.back();
            },
          ),
        ),
        centerTitle: true,
        title: ImageIcon(const AssetImage(CodeLockImages.names), size: 120, color: CodeLockColor.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CodeLockColor.bgGradientStart,
              CodeLockColor.bgGradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<List<File>>(
            stream: controller.streamFiles.stream.asBroadcastStream(),
            builder: (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const CodeLockEmptyState(categoryName: 'Backups');
                }
                return ListView(
                  children: snapshot.data!
                      .map<Widget>((element) {
                            final date = element.modifiedTime!.toLocal();
                            final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                            final dateString = '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
                            final ampm = date.hour >= 12 ? 'PM' : 'AM';
                            final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
                            final timeString = '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $ampm';
                            
                            int bytes = int.tryParse(element.size ?? '0') ?? 0;
                            String sizeString = '';
                            if (bytes < 1024) sizeString = '$bytes B';
                            else if (bytes < 1024 * 1024) sizeString = '${(bytes / 1024).toStringAsFixed(1)} KB';
                            else sizeString = '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: CodeLockColor.glassBg,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: CodeLockColor.glassBorder, width: 1.2),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Last Backup",
                                    style: TextStyle(
                                      color: CodeLockColor.white.withOpacity(0.7),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dateString,
                                        style: TextStyle(
                                          color: CodeLockColor.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        timeString,
                                        style: TextStyle(
                                          color: CodeLockColor.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Divider(color: CodeLockColor.glassBorder, height: 1),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Backup Size",
                                        style: TextStyle(
                                          color: CodeLockColor.white.withOpacity(0.7),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        sizeString,
                                        style: TextStyle(
                                          color: CodeLockColor.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Divider(color: CodeLockColor.glassBorder, height: 1),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextButton.icon(
                                          onPressed: () {
                                            detectOnTap();
                                            CodeLockAlertDialogbox(
                                              context,
                                              titletext: "Delete Backup",
                                              text: "Are you sure you want to delete this backup?\nThis action cannot be undone.",
                                              first: allLanguages!.cancel,
                                              second: allLanguages!.delete,
                                              NoOnPressed: () {
                                                detectOnTap();
                                                Get.back();
                                              },
                                              YesOnPressed: () {
                                                detectOnTap();
                                                Get.back();
                                                controller.deleteBackUp(element.id.toString());
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  snackBar(
                                                    context: context,
                                                    msg: "Backup deleted successfully",
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.delete_outline, color: Color(0xFFFF4D4F), size: 20),
                                          label: const Text("Delete", style: TextStyle(color: Color(0xFFFF4D4F), fontWeight: FontWeight.w600)),
                                          style: TextButton.styleFrom(
                                            backgroundColor: const Color(0xFFFF4D4F).withOpacity(0.1),
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            detectOnTap();
                                            CodeLockAlertDialogbox(
                                              context,
                                              titletext: allLanguages!.restore,
                                              text: allLanguages!.byRestoringDataYou,
                                              first: allLanguages!.cancel,
                                              second: allLanguages!.restore,
                                              NoOnPressed: () {
                                                detectOnTap();
                                                Get.back();
                                              },
                                              YesOnPressed: () {
                                                detectOnTap();
                                                Get.back();
                                                controller.restore(element.id.toString());
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.restore, color: Colors.white, size: 20),
                                          label: const Text("Restore", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: CodeLockColor.accentVibrant,
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          })
                      .toList(),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: CodeLockColor.accentVibrant,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
