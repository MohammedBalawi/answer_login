import 'package:answer_login/shared_pref/shared.dart';
import 'package:flutter/material.dart';
// import 'package:untitled7/pref/shared_pref_controller.dart';

class LanguageProvider extends ChangeNotifier {
   String language =
      SharedPrefController().getValueFor<String>(Key: PreKey.language.name) ?? 'en';

  void changeLanguage() {
    language = language == 'en' ? 'ar' : 'en';
    SharedPrefController().setLanguage(language);
    notifyListeners();
  }
}
