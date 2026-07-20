import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/modules/setting%20screen/setting_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CodeLockColor.homelist,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: const ImageIcon(AssetImage(CodeLockImages.back), size: 10),
            onTap: () {
              detectOnTap();
              Get.back();
            },
          ),
        ),
        centerTitle: true,
        title: const ImageIcon(AssetImage(CodeLockImages.names), size: 120),
      ),
      body: StreamBuilder<List<File>>(
        stream: controller.streamFiles.stream.asBroadcastStream(),

        ///future: controller.getAllBackUp(),
        builder: (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!
                  .map<Widget>((element) => ListTile(
                        title: Text(element.modifiedTime!.toIso8601String()),
                        subtitle: Text(element.size.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                detectOnTap();
                                controller.deleteBackUp(element.id.toString());
                              },
                              icon: const Icon(Icons.delete_forever),
                            ),
                            IconButton(
                              onPressed: () {
                                detectOnTap();
                                controller.restore(element.id.toString());
                              },
                              icon: const Icon(Icons.restore),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: CodeLockColor.homelist,
            ),
          );
        },
      ),
    );
  }
}
