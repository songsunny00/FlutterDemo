import 'package:flutter/material.dart';

class MyDialog {
  static dynamic ctx;

  static void showConfirmDialog(
    @required String msg,
    {
      String title = '提示',
      String confirmText = '确定',
      String cancelText = '取消',
      VoidCallback onConfirmPressed
    }) {
    showDialog<void>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(cancelText, style: TextStyle(color: Colors.black87)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(confirmText),
              onPressed: () {
                onConfirmPressed();
              },
            ),
          ],
        );
      },
    );
  }

}