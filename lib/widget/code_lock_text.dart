import 'package:flutter/cupertino.dart';

class CodeLockText extends StatelessWidget {
  const CodeLockText({
    Key? key,
    this.color,
    this.fontsize,
    this.fontWeight,
    required this.text,
  }) : super(key: key);
  final String text;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,
      ),
    );
  }
}
