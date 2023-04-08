
import 'package:flutter/material.dart';

void showSnack(String msg, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(msg),
    backgroundColor: (Colors.black87),
    action: SnackBarAction(
      label: 'Dismiss',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}