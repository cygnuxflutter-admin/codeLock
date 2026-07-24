import 'dart:ui';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  DatePicker({
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
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
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
                    height: context.getHeight * 0.065,
                    decoration: BoxDecoration(
                      color: CodeLockColor.glassBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: state.hasError ? const Color(0xFFFF6B6B) : CodeLockColor.glassBorder,
                        width: state.hasError ? 1.5 : 1.2,
                      ),
                    ),
                child: Row(
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
                        ),
                        onChanged: detectOnTap(),
                        readOnly: true,
                        onTap: () async {
                          detectOnTap();
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: CodeLockColor.isDark 
                                  ? ThemeData.dark().copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: CodeLockColor.accentVibrant,
                                        onPrimary: Colors.white,
                                        surface: CodeLockColor.bgGradientStart,
                                        onSurface: Colors.white,
                                      ),
                                      dialogBackgroundColor: CodeLockColor.bgGradientEnd,
                                    )
                                  : ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: CodeLockColor.accentVibrant,
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

                            if (pickedDate != null) {
                              String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
                              setState(() {
                                widget.controller!.text = formattedDate;
                              });
                              state.didChange(formattedDate);
                            }
                        },
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: CodeLockColor.white.withOpacity(0.7),
                    ),
                    SizedBox(width: context.getWidth * 0.04),
                  ],
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
