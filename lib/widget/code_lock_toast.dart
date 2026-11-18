import 'package:flutter/material.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';

SnackBar snackBar({
  required BuildContext context,
  required String msg,
  TextStyle? textStyle,
}) {
  final String lowerText = msg.toLowerCase();
  final bool isError = lowerText.contains("wrong") ||
      lowerText.contains("incorrect") ||
      lowerText.contains("error") ||
      lowerText.contains("not match") ||
      lowerText.contains("fail") ||
      lowerText.contains("plz enter") ||
      lowerText.contains("please enter");

  final bool isSuccess = lowerText.contains("success") || lowerText.contains("save");

  final Color accentColor = isError
      ? const Color(0xFFFF4D4F)
      : (isSuccess ? const Color(0xFF10B981) : CodeLockColor.accentVibrant);

  final IconData iconData = isError
      ? Icons.error_outline_rounded
      : (isSuccess ? Icons.check_circle_outline_rounded : Icons.info_outline_rounded);

  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final Color bgColor = isDarkMode ? const Color(0xff3C4253) : const Color(0xffFFFFFF);
  final Color textColor = isDarkMode ? Colors.white : const Color(0xff1A1C29);

  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    padding: EdgeInsets.zero,
    margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
    content: Container(
      decoration: BoxDecoration(
        color: bgColor, // Premium dynamic background
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
                  msg,
                  style: (textStyle ?? const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  )).copyWith(color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
