import 'dart:ui';
import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/backup/clear_appdirectory.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/timer_method.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/widget/code_lock_settingbutton.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/modules/setting%20screen/setting_screen_controller.dart';
import 'package:code_lock/widget/code_lock_alertdialogbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settingscreen extends StatefulWidget {
  Settingscreen({Key? key}) : super(key: key);
  SettingScreenController settingScreenController =
      Get.put(SettingScreenController());

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  final SingletonTimer time = SingletonTimer();

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 24, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: CodeLockColor.white.withOpacity(0.5),
          letterSpacing: 1.2,
        ),
      ),
    );
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
            child: ImageIcon(
              const AssetImage(CodeLockImages.back),
              size: 24,
              color: CodeLockColor.white,
            ),
            onTap: () {
              detectOnTap();
              Get.back();
            },
          ),
        ),
        centerTitle: true,
        title: ImageIcon(
          const AssetImage(CodeLockImages.names),
          size: 120,
          color: CodeLockColor.white,
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
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle("Security"),
                SettingButton(
                  onTap: () {
                    detectOnTap();
                    Get.toNamed(AppRoutes.ChangeCodeLockScreen);
                  },
                  icons: const AssetImage(CodeLockImages.change_codelock),
                  text: allLanguages!.changeCodelock,
                  iconcolor: CodeLockColor.white,
                  iconsize: 30,
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: CodeLockColor.glassBg,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: CodeLockColor.glassBorder,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: CodeLockColor.accentVibrant,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 4.5,
                                  height: 24,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allLanguages!.applicationLockInterval,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: CodeLockColor.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Automatically lock the app after inactivity",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: CodeLockColor.white.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${LocalData.getIsSec.toInt()}s',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: CodeLockColor.accentVibrant,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Slider(
                              value: LocalData.getIsSec,
                              min: 10,
                              max: 60,
                              label: widget.settingScreenController.value.round().toString(),
                              activeColor: CodeLockColor.accentVibrant,
                              inactiveColor: CodeLockColor.glassBorder,
                              thumbColor: CodeLockColor.white,
                              onChanged: (double value) {
                                setState(() {
                                  widget.settingScreenController.value = value;
                                  LocalData.setIsSec(value);
                                });
                              },
                              onChangeStart: (double value) {
                                time.stopTimer();
                              },
                              onChangeEnd: (double value) {
                                LocalData.setIsSec(value);
                                time.resetTimer(value.toInt());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                _buildSectionTitle("Data"),
                SettingButton(
                  onTap: () {
                    detectOnTap();
                    CodeLockAlertDialogbox(
                      context,
                      titletext: CodeLockString.codeLock,
                      text: allLanguages!.thisWillUploadYourSaveDataToYourDrive,
                      first: allLanguages!.notNow,
                      second: allLanguages!.ok,
                      NoOnPressed: () {
                        detectOnTap();
                        Get.back();
                      },
                      YesOnPressed: () {
                        detectOnTap();
                        Get.back(); // Close the alert dialog FIRST
                        widget.settingScreenController.backUp(); // THEN open loading dialog
                      },
                    );
                  },
                  icons: const AssetImage(CodeLockImages.backup),
                  text: allLanguages!.backUp,
                  iconcolor: CodeLockColor.white,
                  iconsize: 30,
                ),
                SettingButton(
                  onTap: () {
                    detectOnTap();
                    Get.toNamed(AppRoutes.restoreScreen);
                  },
                  icons: const AssetImage(CodeLockImages.restore),
                  text: allLanguages!.restore,
                  iconcolor: CodeLockColor.white,
                  iconsize: 30,
                ),
                SettingButton(
                  onTap: () {
                    detectOnTap();
                    CodeLockAlertDialogbox(
                      context,
                      titletext: CodeLockString.codeLock,
                      text: allLanguages!.eraseYourAllDataAreSqure,
                      first: allLanguages!.notNow,
                      second: allLanguages!.ok,
                      NoOnPressed: () {
                        detectOnTap();
                        Get.back();
                      },
                      YesOnPressed: () async {
                        time.stopTimer();
                        LocalData.clear();
                        AppDataBase app = AppDataBase();
                        deleteFiles();
                        await clearImageFolder();
                        await app.resetDataBase();
                        Get.offAllNamed(AppRoutes.SplashScreen);
                      },
                    );
                  },
                  icons: const AssetImage(CodeLockImages.reset_data),
                  text: allLanguages!.resetData,
                  iconcolor: CodeLockColor.white,
                  iconsize: 30,
                ),

                _buildSectionTitle("General"),
                SettingButton(
                  onTap: () {
                    detectOnTap();
                    Get.toNamed(AppRoutes.LanguageScreen);
                  },
                  icons: const AssetImage(CodeLockImages.change_language),
                  text: allLanguages!.changeLanguage,
                  iconcolor: CodeLockColor.white,
                  iconsize: 30,
                ),

                _buildSectionTitle("About"),
                SettingButton(
                  onTap: () {
                    detectOnTap();
                    Get.toNamed(AppRoutes.DisclaimerScreen);
                  },
                  icons: const AssetImage(CodeLockImages.disclaimer),
                  text: allLanguages!.desclaimer,
                  iconcolor: CodeLockColor.white,
                  iconsize: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
