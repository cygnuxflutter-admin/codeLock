import 'dart:async';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/enums.dart';
import 'package:code_lock/custom/image/code_lock_image.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (LocalData.getIsLogin == false || LocalData.getIsLogin == null) {
        Get.offAndToNamed(AppRoutes.StartScreen);
        dashBoardMenu.value = DashBoardMenu.startScreen;
      } else {
        dashBoardMenu.value = DashBoardMenu.masterPassword;
        Get.offAndToNamed(AppRoutes.MasterPassword);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: CodeLockColor.accentVibrant.withOpacity(0.4),
                      blurRadius: 60,
                      spreadRadius: 10,
                      offset: const Offset(0, 0),
                    )
                  ],
                  image: const DecorationImage(
                    image: AssetImage(CodeLockImages.Logo2),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "code",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: CodeLockColor.white,
                      ),
                    ),
                    TextSpan(
                      text: "Lock",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: CodeLockColor.accentVibrant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Secure. Private. Always.",
                style: TextStyle(
                  color: CodeLockColor.white.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
