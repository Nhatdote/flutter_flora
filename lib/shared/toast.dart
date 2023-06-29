import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Toast {
  static const String toastSuccess = 'success';
  static const String toastError = 'error';

  static ScaffoldMessengerState? _scaffoldMessenger;

  static void initialize(BuildContext context) {
    _scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  static void showError(dynamic message) {
    Toast.show(message, type: Toast.toastError);
  }

  static void showSuccess(dynamic message) {
    Toast.show(message, type: Toast.toastSuccess);
  }

  static void show(dynamic message,
      {SnackBarAction? action,
      Color color = const Color(0xFF323232),
      bool hidePrevSnackbar = true,
      String? type,
      int duration = 3,
      SnackBarBehavior behavior = SnackBarBehavior.fixed}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (hidePrevSnackbar) {
        _scaffoldMessenger?.hideCurrentSnackBar();
      }

      var snackBarColor = color;
      if (type != null && [toastSuccess, toastError].contains(type)) {
        snackBarColor = type == toastSuccess ? Colors.green : Colors.redAccent;
      }

      final snackBar = SnackBar(
        behavior: behavior,
        content: message.runtimeType == String ? Text(message) : message,
        action: action,
        backgroundColor: snackBarColor,
        showCloseIcon: true,
        closeIconColor: Colors.white70,
        duration: Duration(seconds: duration),
      );

      _scaffoldMessenger?.showSnackBar(snackBar);
    });
  }
}
