import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/usecases/settings_usecases.dart';

class DarkModeProvider with ChangeNotifier {
  bool _darkMode = false;
  bool _autoDarkMode = true;
  SettingsUseCases settingsUseCases;
  DarkModeProvider({required this.settingsUseCases});

  bool get darkMode => _darkMode;
  bool get autoDarkMode => _autoDarkMode;

  set darkMode(bool value) {
    _darkMode = value;
    settingsUseCases.saveDarkModeInStorage(darkMode: value);
    notifyListeners();
  }

  set autoDarkMode(bool value) {
    _autoDarkMode = value;
    settingsUseCases.saveAutoDarkModeInStorage(autoDarkMode: value);
    notifyListeners();
  }
}
