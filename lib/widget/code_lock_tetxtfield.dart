import 'dart:ui';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:flutter/material.dart';

class codeLockTextfield extends StatefulWidget {
  const codeLockTextfield({
    Key? key,
    required this.firstColor,
    required this.SecondColor,
    required this.HinttextColor,
    this.cursorColor,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.iconButton,
    this.prefixWidget,
    this.onChanged,
    this.validator,
    this.textColor = Colors.white,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final Color firstColor;
  final Color SecondColor;
  final Color HinttextColor;
  final Color? cursorColor;
  final Widget? iconButton;
  final Widget? prefixWidget;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final Color textColor;
  final bool isPassword;

  @override
  State<codeLockTextfield> createState() => _codeLockTextfieldState();
}

class _codeLockTextfieldState extends State<codeLockTextfield> {
  bool _obscureText = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller?.text,
      validator: widget.validator,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: CodeLockColor.glassBg,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: state.hasError 
                          ? const Color(0xFFFF6B6B) 
                          : (_focusNode.hasFocus ? CodeLockColor.accentVibrant : CodeLockColor.glassBorder),
                      width: state.hasError || _focusNode.hasFocus ? 1.5 : 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.prefixWidget != null) ...[
                        SizedBox(width: context.getWidth * 0.02),
                        widget.prefixWidget!,
                      ] else ...[
                        SizedBox(width: context.getWidth * 0.04),
                      ],
                      Expanded(
                        child: TextField(
                          focusNode: _focusNode,
                          textAlignVertical: TextAlignVertical.center,
                          controller: widget.controller,
                          keyboardType: widget.keyboardType,
                          cursorColor: widget.cursorColor ?? CodeLockColor.accentVibrant,
                          onChanged: (val) {
                            state.didChange(val);
                            if (widget.onChanged != null) widget.onChanged!(val);
                          },
                  obscureText: _obscureText,
                  style: TextStyle(
                      color: widget.textColor,
                      fontSize: 16.0,
                      fontFamily: "Inter"),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: widget.HinttextColor.withOpacity(0.5),
                        fontSize: 16.0,
                        fontFamily: "Inter"),
                    suffixIcon: widget.isPassword
                        ? IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: widget.HinttextColor,
                              size: 22,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                        : (widget.iconButton ?? const SizedBox()),
                  ),
                ),
              ),
              if (!widget.isPassword && widget.iconButton == null)
                SizedBox(width: context.getWidth * 0.03),
            ],
          ),
        ),
      ),
    ),
    if (state.hasError)
      Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
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
    );
  }
}
