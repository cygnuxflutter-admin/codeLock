import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'dart:ui';

void CodeLockToast(
  BuildContext context, {
  required String text,
}) {
  final String lowerText = text.toLowerCase();
  final bool isError = lowerText.contains("wrong") ||
      lowerText.contains("incorrect") ||
      lowerText.contains("error") ||
      lowerText.contains("not match") ||
      lowerText.contains("fail") ||
      lowerText.contains("plz enter") ||
      lowerText.contains("please enter");

  final bool isSuccess = lowerText.contains("success");

  final Color accentColor = isError
      ? const Color(0xFFFF4D4F) // Red
      : (isSuccess ? const Color(0xFF10B981) : CodeLockColor.accentVibrant); // Green or Purple

  final IconData iconData = isError
      ? Icons.error_outline_rounded
      : (isSuccess ? Icons.check_circle_outline_rounded : Icons.info_outline_rounded);

  Widget toastWidget = Container(
    margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A).withValues(alpha: 0.9), // Premium dark background
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: accentColor.withValues(alpha: 0.5),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: accentColor,
                size: 24.0,
              ),
              const SizedBox(width: 12.0),
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  showToastWidget(
    toastWidget,
    context: context,
    animation: StyledToastAnimation.slideFromBottomFade,
    reverseAnimation: StyledToastAnimation.slideToBottomFade,
    position: StyledToastPosition.bottom,
    animDuration: const Duration(milliseconds: 300),
    duration: const Duration(seconds: 3),
    curve: Curves.easeOutBack,
    reverseCurve: Curves.easeInCirc,
  );
}
