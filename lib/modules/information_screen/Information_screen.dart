import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/widget/code_lock_toast.dart';
import 'package:code_lock/modules/home_screen/home_screen_controller.dart' hide Status;
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/models/get_database/get_titles.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/widget/code_lock_infocell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:code_lock/widget/code_lock_empty_state.dart';
import 'package:code_lock/widget/code_lock_alertdialogbox.dart';

import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'Information_screen_controller.dart';

class InformationScreen extends GetView<InformationScreenController> {
  InformationScreen({Key? key}) : super(key: key);

  final AppDataBase _appDataBase = AppDataBase();

  final Map<String, dynamic> args = Get.arguments;

  get catMain => null;

  void _showDeleteConfirmationDialog(BuildContext context, TitleModel data) {
    CodeLockAlertDialogbox(
      context,
      titletext: "Delete Record?",
      text: "Are you sure you want to delete this record?",
      first: allLanguages!.cancel,
      second: allLanguages!.delete,
      NoOnPressed: () {
        detectOnTap();
        Get.back();
      },
      YesOnPressed: () async {
        detectOnTap();
        Get.back();
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
        actions: [
          IconButton(
            onPressed: () {
              detectOnTap();
              Get.toNamed(AppRoutes.EditFieldScreen, arguments: {
                'catId': args['catId'],
              });
            },
            icon: Icon(Icons.edit, color: CodeLockColor.white),
          ),
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
                                              'titleName': data.titleName,
                                              'isEditMode': false
                                            },
                                          );
                                        },
                                        child: InfoCell(
                                          TitleName: data.titleName.toString(),
                                          onEdit: () {
                                            detectOnTap();
                                            Get.toNamed(
                                              AppRoutes.DescriptionScreen,
                                              arguments: {
                                                'titleId': data.titleId,
                                                'titleName': data.titleName,
                                                'isEditMode': true
                                              },
                                            );
                                          },
                                          onDelete: () {
                                            detectOnTap();
                                            _showDeleteConfirmationDialog(context, data);
                                          },
                                        ),
                                      ),
                                    );
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
