import 'dart:ui';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCheckbox extends StatefulWidget {
  final String titleText;
  late int colorValue;
  final void Function(String value) checkValue;
  RxBool enable;

  CustomCheckbox({
    super.key,
    required this.titleText,
    required this.checkValue,
    required this.colorValue,
    required this.enable,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: CodeLockColor.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: context.getHeight * 0.065,
                decoration: BoxDecoration(
                  color: CodeLockColor.glassBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CodeLockColor.glassBorder,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.enable.value) {
                                  detectOnTap();
                                  setState(() {
                                    widget.colorValue = 0;
                                    widget.checkValue(CodeLockString.yes);
                                  });
                                }
                              },
                              child: Container(
                                color: widget.colorValue == 0
                                    ? CodeLockColor.accentVibrant.withOpacity(0.8)
                                    : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    CodeLockString.yes,
                                    style: TextStyle(
                                      color: CodeLockColor.white,
                                      fontSize: 16,
                                      fontWeight: widget.colorValue == 0 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 1.2,
                            color: CodeLockColor.glassBorder,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.enable.value) {
                                  detectOnTap();
                                  setState(() {
                                    widget.colorValue = 1;
                                    widget.checkValue(CodeLockString.no);
                                  });
                                }
                              },
                              child: Container(
                                color: widget.colorValue == 1
                                    ? CodeLockColor.accentVibrant.withOpacity(0.8)
                                    : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    CodeLockString.no,
                                    style: TextStyle(
                                      color: CodeLockColor.white,
                                      fontSize: 16,
                                      fontWeight: widget.colorValue == 1 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
