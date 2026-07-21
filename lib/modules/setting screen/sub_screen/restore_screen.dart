import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/modules/setting%20screen/setting_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:code_lock/widget/code_lock_alertdialogbox.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
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
                return ListView(
                  children: snapshot.data!
                      .map<Widget>((element) => ListTile(
                            title: Text(element.modifiedTime!.toIso8601String(), style: const TextStyle(color: Colors.white)),
                            subtitle: Text(element.size.toString(), style: const TextStyle(color: Colors.white70)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    detectOnTap();
                                    controller.deleteBackUp(element.id.toString());
                                  },
                                  icon: const Icon(Icons.delete_forever, color: Colors.white70),
                                ),
                                IconButton(
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
                                  icon: const Icon(Icons.restore, color: Colors.white),
                                ),
                              ],
                            ),
                          ))
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
