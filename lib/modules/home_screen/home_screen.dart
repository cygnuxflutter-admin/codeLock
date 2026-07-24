import 'dart:ui';
import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/widget/code_lock_toast.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/models/get_database/get_catmain.dart';
import 'package:code_lock/modules/home_screen/home_screen_controller.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/widget/code_lock_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:code_lock/widget/code_lock_empty_state.dart';
import 'package:code_lock/widget/code_lock_alertdialogbox.dart';

import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LanguageScreenController languageScreenController =
      Get.put(LanguageScreenController());

  HomeScreenController homeScreen = HomeScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow gradient behind AppBar
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CodeLockColor.accentVibrant.withOpacity(0.25), // Reduced elegant purple shadow
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            detectOnTap();
            Get.toNamed(AppRoutes.FieldScreen);
          },
          backgroundColor: CodeLockColor.accentVibrant,
          elevation: 0, // Disable default black shadow
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: GestureDetector(
                onTap: () {
                  homeScreen.time.stopTimer();
                  Get.offAllNamed(AppRoutes.MasterPassword);
                },
                child: ImageIcon(
                  const AssetImage(CodeLockImages.lock),
                  size: 38,
                  color: CodeLockColor.white, // make icon light
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: ImageIcon(
          const AssetImage(CodeLockImages.names), 
          size: 120,
          color: CodeLockColor.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                detectOnTap();
                Get.toNamed(AppRoutes.SettingScreen);
              },
              child: ImageIcon(
                const AssetImage(CodeLockImages.setting), 
                size: 38,
                color: CodeLockColor.white,
              ),
            ),
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
        child: SafeArea( // Keep content below AppBar
          child: Column(
            children: [
              SizedBox(height: context.getHeight * 0.02),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: CatMainTableData(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CatMainTableData extends GetView<HomeScreenController> {
  CatMainTableData({Key? key}) : super(key: key);

  final AppDataBase _appDataBase = AppDataBase();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch (controller.status.value) {
          case Status.loading:
            return Center(
              child: CircularProgressIndicator(color: CodeLockColor.accentVibrant),
            );

          case Status.error:
            return Center(child: Text(CodeLockString.error, style: TextStyle(color: CodeLockColor.white)));

          case Status.done:
            return StreamBuilder<List<CatMainModel>>(
              initialData: controller.catMainTable,
              stream: controller.catMainTableStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CatMainModel> catMainList = snapshot.data!;

                  if (controller.catMainTable.isEmpty) {
                    return GestureDetector(
                      onTap: detectOnTap,
                      child: const CodeLockEmptyState(
                        categoryName: 'Home',
                        isHomeScreen: true,
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 90), // Prevent FAB from hiding last item
                    itemCount: catMainList.length,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: context.getWidth * 0.04),
                    itemBuilder: (context, index) {
                      CatMainModel catMain = catMainList[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.getWidth * 0.05),
                        child: SwipeActionCell(
                          key: Key(catMain.catId.toString()),
                          backgroundColor: Colors.transparent,
                          trailingActions: [
                            SwipeAction(
                              backgroundRadius: 16.0,
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
                                handler(false); // Close the swipe action gracefully

                                CodeLockAlertDialogbox(
                                  context,
                                  titletext: "Delete Category?",
                                  text: "Are you sure you want to delete this category?",
                                  first: allLanguages!.cancel,
                                  second: allLanguages!.delete,
                                  NoOnPressed: () {
                                    detectOnTap();
                                    Get.back();
                                  },
                                  YesOnPressed: () async {
                                    detectOnTap();
                                    Get.back();
                                    String? catIdToDelete = catMain.catId;
                                    if (catIdToDelete != null) {
                                      await _appDataBase.deleteDatabase(catIdToDelete, Tables.catMain);
                                      await _appDataBase.deleteDatabase(catIdToDelete, Tables.subCat);
                                      await _appDataBase.deleteDatabase(catIdToDelete, Tables.titles);
                                      await _appDataBase.deleteDatabase(catIdToDelete, Tables.descriptions);
                                      controller.getCatMainData();
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
                              },
                            ),
                        ],
                        child: GestureDetector(
                          onTap: () {
                            int count = int.parse(catMain.openedCount ?? '0');

                            final updateCount = CatMainModel(
                              catId: catMain.catId,
                              catName: catMain.catName,
                              openedCount: (count + 1).toString(),
                              imgId: catMain.imgId,
                            );
                            _appDataBase.updateCount(
                              updateCount.toMap(),
                              Tables.catMain,
                              catMain.catId.toString(),
                            );

                            detectOnTap();

                            Get.toNamed(
                              AppRoutes.InformationScreen,
                              arguments: {
                                'catId': catMain.catId,
                                'catName': catMain.catName,
                                'imgId': catMain.imgId,
                              },
                            );
                          },
                          child: Home_container(
                            Label: catMain.catName.toString(),
                            CountNo: controller
                                .getTitleDataContain(catMain.catId.toString())
                                .length,
                            MenuIcon: AssetImage(
                              listOfIcon(catMain.imgId.toString()),
                            ),
                          ),
                        ),
                      ));
                    },
                  );
                }
                else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: CodeLockColor.accentVibrant,
                    ),
                  );
                }
              },
            );
        }
      },
    );
  }
}
