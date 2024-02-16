import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMsg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void show_Simple_Snackbar(
      BuildContext context, String msg, String msgDes) {
    Flushbar(
      duration: Duration(seconds: 3),
      title: msg,
      message: msgDes,
    )..show(context);
  }

  static void flushBarErrorMessage(String string, BuildContext context) {}
}
