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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _glowOpacity;
  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleOffset;
  late Animation<double> _subtitleOpacity;

  @override
  void initState() {
    super.initState();
    
    // Total animation duration is 2.0 seconds.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // 0.2s to 0.6s (Interval 0.1 to 0.3): Logo Scale 0% -> 100%
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.3, curve: Curves.easeOutBack),
      ),
    );

    // 0.6s to 1.8s (Interval 0.3 to 0.9): Purple Glow increases
    // 1.8s to 2.0s (Interval 0.9 to 1.0): Glow reduces slightly
    _glowOpacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 60, // 60% of the remaining 0.7 interval (0.3 to 1.0)
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.6).chain(CurveTween(curve: Curves.easeOut)),
        weight: 10, // 10% of the remaining 0.7 interval
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0),
      ),
    );

    // 0.9s to 1.2s (Interval 0.45 to 0.6): Title Fade In & Slide Down
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.6, curve: Curves.easeIn),
      ),
    );
    _titleOffset = Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.6, curve: Curves.easeOut),
      ),
    );

    // 1.2s to 1.5s (Interval 0.6 to 0.75): Subtitle Fade In
    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.75, curve: Curves.easeIn),
      ),
    );

    // Start the animation
    _controller.forward();

    // Navigate to next screen after 3 seconds to allow animation to complete
    Future.delayed(const Duration(seconds: 3), () {
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo & Glow
                  Transform.scale(
                    scale: _logoScale.value,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: _glowOpacity.value > 0
                            ? [
                                BoxShadow(
                                  color: CodeLockColor.accentVibrant
                                      .withOpacity(_glowOpacity.value * 0.4),
                                  blurRadius: 20 + (_glowOpacity.value * 40),
                                  spreadRadius: (_glowOpacity.value * 10),
                                  offset: const Offset(0, 0),
                                )
                              ]
                            : [],
                        image: const DecorationImage(
                          image: AssetImage(CodeLockImages.Logo2),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Animated Title (Slide & Fade)
                  SlideTransition(
                    position: _titleOffset,
                    child: Opacity(
                      opacity: _titleOpacity.value,
                      child: RichText(
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
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Animated Subtitle (Fade)
                  Opacity(
                    opacity: _subtitleOpacity.value,
                    child: Text(
                      "Secure. Private. Always.",
                      style: TextStyle(
                        color: CodeLockColor.white.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
