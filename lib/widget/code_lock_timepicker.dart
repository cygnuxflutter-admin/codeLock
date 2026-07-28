import 'dart:ui';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  TimePicker({
    Key? key,
    this.controller,
    required this.titleText,
    required this.hintText,
    this.validator,
    this.enabled,
  }) : super(key: key);

  final TextEditingController? controller;
  final String titleText;
  final String hintText;
  final String? Function(String?)? validator;
  bool? enabled;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: FormField<String>(
        initialValue: widget.controller?.text,
        validator: widget.validator,
        builder: (FormFieldState<String> state) {
          return Column(
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
                    decoration: BoxDecoration(
                      color: CodeLockColor.glassBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: state.hasError ? const Color(0xFFFF6B6B) : CodeLockColor.glassBorder,
                        width: state.hasError ? 1.5 : 1.2,
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: state.hasError ? const Color(0xFFFF6B6B) : CodeLockColor.accentVibrant,
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
                        cursorColor: CodeLockColor.accentVibrant,
                        enabled: widget.enabled,
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
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onChanged: detectOnTap(),
                        readOnly: true,
                        onTap: () async {
                          detectOnTap();
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: CodeLockColor.isDark
                                    ? ThemeData.dark().copyWith(
                                        colorScheme: ColorScheme.dark(
                                          primary: CodeLockColor.accentVibrant,
                                          secondary: CodeLockColor.accentVibrant,
                                          tertiary: CodeLockColor.accentVibrant,
                                          onPrimary: Colors.white,
                                          surface: CodeLockColor.bgGradientStart,
                                          onSurface: Colors.white,
                                        ),
                                        dialogBackgroundColor: CodeLockColor.bgGradientEnd,
                                      )
                                    : ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: CodeLockColor.accentVibrant,
                                          secondary: CodeLockColor.accentVibrant,
                                          tertiary: CodeLockColor.accentVibrant,
                                          onPrimary: Colors.white,
                                          surface: CodeLockColor.bgGradientStart,
                                          onSurface: Colors.black,
                                        ),
                                        dialogBackgroundColor: CodeLockColor.bgGradientEnd,
                                      ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedTime != null) {
                            String formattedTime = pickedTime.format(context);
                            setState(() {
                              widget.controller!.text = formattedTime;
                            });
                            state.didChange(formattedTime);
                          }
                        },
                      ),
                    ),
                    Icon(
                      Icons.access_time,
                      color: CodeLockColor.white.withOpacity(0.7),
                    ),
                    SizedBox(width: context.getWidth * 0.04),
                  ],
                ),
              ),
            ),
          ),
        ),
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 4.0),
              child: Text(
                state.errorText!,
                style: const TextStyle(
                  color: Color(0xFFFF6B6B),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      );
    },
    ),
    );
  }
}
