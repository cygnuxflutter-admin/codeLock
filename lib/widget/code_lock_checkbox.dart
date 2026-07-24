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
  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.titleText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CodeLockColor.white.withOpacity(0.9),
              ),
            ),
          ),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: CodeLockColor.glassBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CodeLockColor.glassBorder, width: 1.2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: widget.enable.value ? () {
                      detectOnTap();
                      setState(() {
                        widget.colorValue = 1;
                        widget.checkValue(CodeLockString.no);
                      });
                    } : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.colorValue == 1 
                            ? CodeLockColor.accentVibrant 
                            : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(11)),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No",
                              style: TextStyle(
                                color: CodeLockColor.white,
                                fontSize: 16,
                                fontWeight: widget.colorValue == 1 ? FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                            if (widget.colorValue == 1) ...[
                              const SizedBox(width: 8),
                              Icon(Icons.check_circle, color: CodeLockColor.white, size: 20),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(width: 1.2, color: CodeLockColor.glassBorder),
                Expanded(
                  child: GestureDetector(
                    onTap: widget.enable.value ? () {
                      detectOnTap();
                      setState(() {
                        widget.colorValue = 0;
                        widget.checkValue(CodeLockString.yes);
                      });
                    } : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.colorValue == 0 
                            ? CodeLockColor.accentVibrant 
                            : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(right: Radius.circular(11)),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                color: CodeLockColor.white,
                                fontSize: 16,
                                fontWeight: widget.colorValue == 0 ? FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                            if (widget.colorValue == 0) ...[
                              const SizedBox(width: 8),
                              Icon(Icons.check_circle, color: CodeLockColor.white, size: 20),
                            ]
                          ],
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
    );
  }
}
