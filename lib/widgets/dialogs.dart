import 'package:flutter/material.dart';

enum alertDialogAction { cancel, save }

class Dialogs {
  static alertDialog(BuildContext context, String title, String body,
      String cancel, String save, List<Widget>? actions) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(body),
            actions: actions,
          );
        });
  }
}
