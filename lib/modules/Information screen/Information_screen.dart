import 'package:code_lock/app_database/app_database.dart';
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
              child: const Text("Cancel", style: TextStyle(color: Colors.white)),
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
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4D4F),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Delete", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showMoreBottomSheet(BuildContext context, TitleModel data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1B1F2A),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
              left: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
              right: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, -5),
              )
            ]
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CodeLockColor.accentVibrant,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.description_outlined, // Generic icon for info item
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          data.titleName ?? "Item",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Divider(color: Colors.white.withValues(alpha: 0.1), height: 1, thickness: 1),
                
                // Edit
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(sheetContext);
                      Get.toNamed(
                        AppRoutes.DescriptionScreen,
                        arguments: {
                          'titleId': data.titleId,
                          'titleName': data.titleName
                        },
                      );
                    },
                    splashColor: CodeLockColor.accentVibrant.withValues(alpha: 0.3),
                    highlightColor: CodeLockColor.accentVibrant.withValues(alpha: 0.1),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 56),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Icon(Icons.edit_outlined, color: Colors.white, size: 24),
                          SizedBox(width: 16),
                          Text("Edit", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
                
                Divider(color: Colors.white.withValues(alpha: 0.1), height: 1, thickness: 1),
                
                // Delete
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _showDeleteConfirmationDialog(context, data);
                    },
                    splashColor: const Color(0xFFFF4D57).withValues(alpha: 0.3),
                    highlightColor: const Color(0xFFFF4D57).withValues(alpha: 0.1),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 56),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Icon(Icons.delete_outline_rounded, color: const Color(0xFFFF4D57), size: 24),
                          SizedBox(width: 16),
                          Text("Delete", style: TextStyle(color: Color(0xFFFF4D57), fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
                
                Divider(color: Colors.white.withValues(alpha: 0.1), height: 1, thickness: 1),
                
                // Cancel
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(sheetContext);
                    },
                    splashColor: const Color(0xFF9AA0AC).withValues(alpha: 0.2),
                    highlightColor: const Color(0xFF9AA0AC).withValues(alpha: 0.1),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 56),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Icon(Icons.close_rounded, color: const Color(0xFF9AA0AC), size: 24),
                          SizedBox(width: 16),
                          Text("Cancel", style: TextStyle(color: Color(0xFF9AA0AC), fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow gradient behind AppBar
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
        actions: [
          GestureDetector(
              onTap: () {
                detectOnTap();
                Get.toNamed(AppRoutes.Infoaddvalue, arguments: args['catId']);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageIcon(
                  const AssetImage(CodeLockImages.add),
                  color: CodeLockColor.white, // light icon
                  size: 33,
                ),
              ))
        ],
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
                                        content: const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.delete_outline_rounded, color: Colors.white, size: 28),
                                            SizedBox(height: 4),
                                            Text("Delete", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        onTap: (handler) async {
                                          detectOnTap();
                                          HapticFeedback.lightImpact();
                                          handler(false); // Close swipe action
                                          _showDeleteConfirmationDialog(context, data);
                                        },
                                      ),
                                      SwipeAction(
                                        backgroundRadius: 0.0,
                                        performsFirstActionWithFullSwipe: false,
                                        widthSpace: 92,
                                        color: CodeLockColor.accentVibrant,
                                        content: const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit_outlined, color: Colors.white, size: 28),
                                            SizedBox(height: 4),
                                            Text("Edit", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        onTap: (handler) async {
                                          detectOnTap();
                                          HapticFeedback.lightImpact();
                                          handler(false); // Close swipe action
                                          Get.toNamed(
                                            AppRoutes.DescriptionScreen,
                                            arguments: {
                                              'titleId': data.titleId,
                                              'titleName': data.titleName
                                            },
                                          );
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
                                        onMoreTap: () {
                                          detectOnTap();
                                          HapticFeedback.lightImpact();
                                          _showMoreBottomSheet(context, data);
                                        },
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
