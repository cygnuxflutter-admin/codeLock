import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisclaimerScreen extends GetView {
  const DisclaimerScreen({Key? key}) : super(key: key);

  List<String> getDisclaimerPoints() {
    String rawText = allLanguages?.desclaimerText ?? "";
    if (rawText.isEmpty) return [];
    
    // Split by double newline to get individual points
    List<String> points = rawText.split('\n\n');
    return points.where((p) => p.trim().isNotEmpty).toList();
  }

  IconData getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.image_outlined;
      case 1:
        return Icons.cloud_done_outlined;
      case 2:
        return Icons.lock_outline;
      case 3:
        return Icons.timer_outlined;
      case 4:
        return Icons.category_outlined;
      case 5:
        return Icons.security_outlined;
      case 6:
        return Icons.cloud_download_outlined;
      case 7:
        return Icons.language_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> disclaimerPoints = getDisclaimerPoints();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            color: Colors.transparent, // Increases touch area
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: ImageIcon(
              const AssetImage(CodeLockImages.back),
              size: 24,
              color: CodeLockColor.white,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          detectOnTap();
        },
        child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allLanguages?.desclaimer ?? "Disclaimer",
                        style: TextStyle(
                          color: CodeLockColor.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Please read the following information carefully.",
                        style: TextStyle(
                          color: CodeLockColor.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 10),

                // Content list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                    itemCount: disclaimerPoints.length,
                    itemBuilder: (context, index) {
                      String pointText = disclaimerPoints[index];
                      // Remove numbering prefix (e.g., "1. ") if present for cleaner UI
                      pointText = pointText.replaceFirst(RegExp(r'^\d+\.\s*'), '');

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: CodeLockColor.glassBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: CodeLockColor.glassBorder,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: CodeLockColor.accentVibrant.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                getIconForIndex(index),
                                color: CodeLockColor.accentVibrant,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                pointText,
                                style: TextStyle(
                                  color: CodeLockColor.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
