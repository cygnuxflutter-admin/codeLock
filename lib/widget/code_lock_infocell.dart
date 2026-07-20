import 'dart:ui';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCell extends StatelessWidget {
  InfoCell({
    required this.TitleName,
    this.onMoreTap,
    Key? key,
  }) : super(key: key);

  final String TitleName;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: context.getHeight * 0.08,
          decoration: BoxDecoration(
            color: CodeLockColor.glassBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: CodeLockColor.glassBorder,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: CodeLockColor.accentVibrant,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                width: 4.5,
              ),
              SizedBox(width: context.getWidth * 0.04),
              Expanded(
                child: Text(
                  TitleName.trim().isEmpty ? "- -" : TitleName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: CodeLockColor.white, // light text
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (onMoreTap != null)
                IconButton(
                  onPressed: onMoreTap,
                  icon: const Icon(Icons.more_vert, color: Colors.white70),
                  splashRadius: 20,
                ),
              if (onMoreTap == null) SizedBox(width: context.getWidth * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
