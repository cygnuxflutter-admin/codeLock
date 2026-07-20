import 'dart:ui';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:flutter/material.dart';

class Home_container extends StatelessWidget {
  const Home_container({
    required this.Label,
    required this.CountNo,
    required this.MenuIcon,
    Key? key,
  }) : super(key: key);

  final String Label;
  final int CountNo;
  final AssetImage MenuIcon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: context.getHeight * 0.1, // slightly taller for modern feel
            decoration: BoxDecoration(
              color: CodeLockColor.glassBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: CodeLockColor.glassBorder,
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: context.getWidth * 0.04),
                // Icon Container (Using Login Button Gradient)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        CodeLockColor.accentVibrant,
                        CodeLockColor.accentVibrant.withOpacity(0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CodeLockColor.accentVibrant.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image(
                    height: 28,
                    color: CodeLockColor.white, // bright icon
                    image: MenuIcon,
                  ),
                ),
                SizedBox(width: context.getWidth * 0.04),
                // Label
                Expanded(
                  child: Text(
                    Label,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: CodeLockColor.white, // light text
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                // Divider line
                Container(
                  height: context.getHeight * 0.06,
                  width: 1.5,
                  color: CodeLockColor.glassBorder,
                ),
                SizedBox(width: context.getWidth * 0.04),
                // Count
                SizedBox(
                  width: 45,
                  child: Center(
                    child: Text(
                      CountNo.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: CodeLockColor.white, // light text
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.getWidth * 0.02),
              ],
            ),
          ),
        ),
    );
  }
}
