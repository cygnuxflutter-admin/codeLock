
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';
import 'custom/Image/code_lock_image.dart';
import 'custom/enums.dart';

bool isAdShown = false;

class AppLifecycleObserver extends WidgetsBindingObserver {
  bool isFirstTime = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        showOverlayImage();
        break;
      case AppLifecycleState.paused:
        inActive();
        isAdShown = false;
        print('App is paused');
        break;
      case AppLifecycleState.resumed:
        onResume();
        break;
      default:
        break;
    }
  }

  void onResume() {
    if (isFirstTime == true) {
      isFirstTime = false;
    } else {
      if (!isAdShown) {
        if (LocalData.getIsLogin == false || LocalData.getIsLogin == null) {
          Get.offAndToNamed(AppRoutes.StartScreen);
          dashBoardMenu.value = DashBoardMenu.startScreen;
        } else {
          dashBoardMenu.value = DashBoardMenu.masterPassword;
          Get.offAndToNamed(AppRoutes.MasterPassword);
        }
      }
      isAdShown = true;
    }
  }

  void inActive() async {
    await Get.toNamed(AppRoutes.SplashScreen);
  }

  void showOverlayImage() {
    OverlayEntry overlayEntry;

    // Create a widget that represents the overlay image
    Widget overlayImage = Image.asset(
      CodeLockImages.backGround,
      fit: BoxFit.cover,
    );

    // Create an overlay entry to display the image
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: overlayImage,
        ),
      );
    });

    // Obtain the overlay state using the context variable
    if (Get.overlayContext != null) {
      OverlayState? overlayState = Overlay.maybeOf(Get.overlayContext!);
      overlayState?.insert(overlayEntry);
    }
  }
}