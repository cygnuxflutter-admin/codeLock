import 'dart:ui';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
    required this.onTap,
    required this.icons,
    required this.text,
    required this.iconcolor,
    required this.iconsize,
  }) : super(key: key);

  final AssetImage icons;
  final String text;
  final Color iconcolor;
  final double iconsize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 80,
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(18),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CodeLockColor.accentVibrant,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                        ),
                      ),
                      width: 4.5,
                      ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 32,
                      child: Center(
                        child: Image(
                          image: icons,
                          color: iconcolor,
                          height: iconsize,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: CodeLockColor.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: CodeLockColor.white.withOpacity(0.5),
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
