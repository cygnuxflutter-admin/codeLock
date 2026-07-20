import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

CodeLockAlertDialogbox(
  BuildContext context, {
  required String titletext,
  required String text,
  required String first,
  required String second,
  required Function() NoOnPressed,
  required Function() YesOnPressed,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CupertinoAlertDialog(
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: NoOnPressed,
          child: Text(first),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: YesOnPressed,
          child: Text(second),
        ),
      ],
      title: Text(titletext),
      content: Text(text),
    ),
  );
}
