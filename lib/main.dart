import 'package:flutter/material.dart';
import 'package:my_profile_app/screens/welcome_screen.dart';
import 'package:my_profile_app/theme/app_theme.dart';

void main() => runApp(const MyProfileApp());

class MyProfileApp extends StatefulWidget {
  const MyProfileApp({super.key});

  @override
  State<MyProfileApp> createState() => _MyProfileAppState();
}

class _MyProfileAppState extends State<MyProfileApp> {
  bool _dark = false;

  void _toggle() => setState(() => _dark = !_dark);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
      home: WelcomeScreen(onToggle: _toggle, dark: _dark),
    );
  }
}
