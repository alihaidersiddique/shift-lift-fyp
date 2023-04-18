import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarUtil {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    String message,
  ) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
        duration: const Duration(milliseconds: 1500),
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0, // Inner padding for SnackBar content.
          vertical: 15.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

void showCircularProgressIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    },
  );
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.black,
        duration: const Duration(milliseconds: 1500),
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0, // Inner padding for SnackBar content.
          vertical: 15.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
}

void navigateTo(BuildContext context, String page) {
  context.go(page);
}
