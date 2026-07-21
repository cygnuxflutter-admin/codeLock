import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/widget/code_lock_toast.dart';
import 'package:code_lock/modules/Home Screen/home_screen_controller.dart' hide Status;
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/models/get%20Database/get_titles.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/widget/code_lock_infocell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:code_lock/widget/code_lock_empty_state.dart';

import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'Information_screen_controller.dart';

class InformationScreen extends GetView<InformationScreenController> {
  InformationScreen({Key? key}) : super(key: key);

  final AppDataBase _appDataBase = AppDataBase();

  final Map<String, dynamic> args = Get.arguments;

  get catMain => null;

  void _showDeleteConfirmationDialog(BuildContext context, TitleModel data) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF334155), width: 1),
          ),
          title: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4D4F).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete_outline, color: Color(0xFFFF4D4F), size: 32),
              ),
              const SizedBox(height: 16),
              const Text(
                "Delete Category?",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: const Text(
            "Are you sure you want to delete this category?",
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFF334155)),
                ),
              ),
              child: Text(allLanguages!.cancel, style: const TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                String? catIdToDelete = data.titleId;
                if (catIdToDelete != null) {
                  await _appDataBase.deleteTitleDatabase(catIdToDelete, Tables.titles);
                  await _appDataBase.deleteTitleDatabase(catIdToDelete, Tables.descriptions);
                  if (Get.isRegistered<HomeScreenController>()) {
                    Get.find<HomeScreenController>().getCatMainData();
                    Get.find<HomeScreenController>().getTitleData();
                  }
                  controller.getTitleData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(
                      context: context,
                      msg: "Deleted Successfully",
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4D4F),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(allLanguages!.delete, style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow gradient behind AppBar
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          detectOnTap();
          Get.toNamed(AppRoutes.Infoaddvalue, arguments: args['catId']);
        },
        backgroundColor: CodeLockColor.accentVibrant,
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false, // hide the default back arrow
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            detectOnTap();
            if (Get.isRegistered<HomeScreenController>()) {
              Get.find<HomeScreenController>().getCatMainData();
              Get.find<HomeScreenController>().getTitleData();
            }
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ImageIcon(
              const AssetImage(CodeLockImages.back),
              color: CodeLockColor.white, // light icon
              size: 10,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          args['catName'],
          style: TextStyle(color: CodeLockColor.white, fontWeight: FontWeight.bold),
        ),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () {
                    switch (controller.status.value) {
                      case Status.loading:
                        return Center(
                          child: CircularProgressIndicator(
                            color: CodeLockColor.accentVibrant,
                          ),
                        );

                      case Status.error:
                        return Center(
                          child: Text(
                            CodeLockString.error,
                            style: TextStyle(fontSize: 30, color: CodeLockColor.white),
                          ),
                        );

                      case Status.done:
                        if (controller.getTitleDataContain().isEmpty) {
                          return SizedBox(
                            height: context.getHeight * 0.7, // Adjust height so it centers nicely below AppBar
                            child: CodeLockEmptyState(
                              categoryName: args['catName'],
                              imgId: args['imgId'], // Pass the exact image ID!
                              onAddTap: () {
                                detectOnTap();
                                Get.toNamed(AppRoutes.Infoaddvalue, arguments: args['catId']);
                              },
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              const SizedBox(height: 25),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(), // Important for SingleChildScrollView
                                itemCount: controller.dataIn.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(height: context.getWidth * 0.03),
                                itemBuilder: (context, index) {
                                  TitleModel data = controller.dataIn[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: SwipeActionCell(
                                      key: Key(catMain.toString()), // key change
                                      backgroundColor: Colors.transparent, // Fix white background issue
                                    trailingActions: [
                                      SwipeAction(
                                        backgroundRadius: 12.0,
                                        performsFirstActionWithFullSwipe: false,
                                        widthSpace: 92,
                                        color: const Color(0xFFFF4D4F),
                                        content: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 28),
                                            const SizedBox(height: 4),
                                            Text(allLanguages!.delete, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        onTap: (handler) async {
                                          detectOnTap();
                                          HapticFeedback.lightImpact();
                                          handler(false); // Close swipe action
                                          _showDeleteConfirmationDialog(context, data);
                                        },
                                      ),
                                      ],
                                    child: GestureDetector(
                                      onTap: () {
                                        detectOnTap();

                                        final updateCount = TitleModel(
                                          catId: data.catId,
                                          titleId: data.titleId,
                                          titleName: data.titleName,
                                          openedCount:
                                              (int.parse(data.openedCount ?? '0') +
                                                      1)
                                                  .toString(),
                                        );

                                        _appDataBase.updateTitleCount(
                                            updateCount.toMap(),
                                            Tables.titles,
                                            data.titleId.toString());

                                        Get.toNamed(
                                          AppRoutes.DescriptionScreen,
                                          arguments: {
                                            'titleId': data.titleId,
                                            'titleName': data.titleName
                                          },
                                        );
                                      },
                                      child: InfoCell(
                                        TitleName: data.titleName.toString(),
                                      ),
                                    ),
                                  ));
                                },
                              ),
                              const SizedBox(height: 25),
                            ],
                          );
                        }
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
