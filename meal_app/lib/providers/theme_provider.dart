// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;
  var tm = ThemeMode.system;

  changeThemeMode(val) {
    tm = val;
    notifyListeners();

    saveMode(2);
  }

  String map(ThemeMode tm) {
    if (tm == ThemeMode.system)
      return 'system';
    else if (tm == ThemeMode.light)
      return 'light';
    else
      return 'dark';
  }

  void saveMode(flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (flag) {
      case 0:
        prefs.setInt('primaryColor', primaryColor.value);
        break;
      case 1:
        prefs.setInt('accentColor', accentColor.value);
        break;
      case 2:
        prefs.setString('themeMode', map(tm));
        break;
    }
  }

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;
    final int alpha = color.alpha;

    final Map<int, Color> shades = {
      50: Color.fromARGB(alpha, red, green, blue),
      100: Color.fromARGB(alpha, red, green, blue),
      200: Color.fromARGB(alpha, red, green, blue),
      300: Color.fromARGB(alpha, red, green, blue),
      400: Color.fromARGB(alpha, red, green, blue),
      500: Color.fromARGB(alpha, red, green, blue),
      600: Color.fromARGB(alpha, red, green, blue),
      700: Color.fromARGB(alpha, red, green, blue),
      800: Color.fromARGB(alpha, red, green, blue),
      900: Color.fromARGB(alpha, red, green, blue),
    };

    return MaterialColor(color.value, shades);
  }

  changeColor(Color newColor, bool isPrimary) {
    if (isPrimary) {
      primaryColor = getMaterialColor(newColor);
    } else {
      accentColor = getMaterialColor(newColor);
    }

    notifyListeners();
    saveMode(isPrimary ? 0 : 1);
  }

  void loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String themeMode = prefs.getString('themeMode') ?? 'system';
    if (themeMode == 'system')
      tm = ThemeMode.system;
    else if (themeMode == 'light')
      tm = ThemeMode.light;
    else
      tm = ThemeMode.dark;

    primaryColor = getMaterialColor(Color(prefs.getInt('primaryColor')!));
    accentColor = getMaterialColor(Color(prefs.getInt('accentColor')!));
    notifyListeners();
  }
}
