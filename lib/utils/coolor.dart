import 'package:flutter/material.dart';
class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode =>themeMode==ThemeMode.dark;
  void toggleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
class Coolors{
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.light(),
  );
}