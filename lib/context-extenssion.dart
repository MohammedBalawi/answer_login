import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



extension ContextExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  void showMessage({required String message, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red.shade400 : Colors.green,
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
