import 'dart:ui';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:flutter/material.dart';

class CodeLockButton extends StatelessWidget {
  const CodeLockButton({
    Key? key,
    this.size,
    this.color = Colors.white,
    required this.buttonText,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.buttonColor,
  }) : super(key: key);
  
  final Size? size;
  final Color? color;
  final Color? buttonColor;
  final String buttonText;
  final FontWeight? fontWeight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size?.width,
        height: size?.height ?? 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              CodeLockColor.accentVibrant,
              CodeLockColor.accentVibrant.withOpacity(0.8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: CodeLockColor.accentVibrant.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: color,
              fontWeight: fontWeight,
              fontSize: 18,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}
