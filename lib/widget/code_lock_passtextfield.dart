import 'dart:ui';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:flutter/material.dart';

class PassTextField extends StatefulWidget {
  PassTextField({
    Key? key,
    this.controller,
    required this.titleText,
    required this.hintText,
    required this.keyboardType,
    this.enabled,
    required this.obscureText,
  }) : super(key: key);

  final TextEditingController? controller;
  final String titleText;
  final String hintText;
  final TextInputType keyboardType;
  bool? enabled;
  bool obscureText;

  @override
  State<PassTextField> createState() => _PassTextFieldState();
}

class _PassTextFieldState extends State<PassTextField> {
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
              color: CodeLockColor.white.withOpacity(0.9), // Light title text
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
                    SizedBox(width: context.getWidth * 0.04),
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: widget.controller,
                        keyboardType: widget.keyboardType,
                        cursorColor: CodeLockColor.accentVibrant,
                        enabled: widget.enabled,
                        obscureText: widget.obscureText,
                        style: TextStyle(color: CodeLockColor.white, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                            color: CodeLockColor.white.withOpacity(0.4),
                            fontSize: 16
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: detectOnTap(),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          detectOnTap();
                          widget.obscureText = !widget.obscureText;
                        });
                      },
                      icon: Icon(
                        widget.obscureText ? Icons.visibility_off : Icons.visibility,
                        color: CodeLockColor.white.withOpacity(0.7),
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
