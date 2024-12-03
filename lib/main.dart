import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Setting_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  Future<void> _saveThemePreference(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDark);
  }

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkTheme = isDark;
    });
    _saveThemePreference(isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Settings',
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home:
          SettingsPage(onThemeChanged: _toggleTheme, isDarkTheme: _isDarkTheme),
    );
  }
}
