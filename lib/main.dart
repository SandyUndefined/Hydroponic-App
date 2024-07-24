import 'package:flutter/material.dart';
import 'package:hydrophonic/screens/home_screen.dart';
import 'package:hydrophonic/utils/color_palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Hydroponic App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: ColorPalette.primaryColor,
          secondary: ColorPalette.secondaryColor,
          tertiary: ColorPalette.accentColor,
          background: ColorPalette.backgroundColor,
        ),
        scaffoldBackgroundColor: ColorPalette.backgroundColor,
        appBarTheme: const AppBarTheme(
          color: ColorPalette.primaryColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: ColorPalette.primaryColor),
          bodyMedium: TextStyle(color: ColorPalette.primaryColor),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: ColorPalette.accentColor,
          unselectedLabelColor: ColorPalette.backgroundColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ColorPalette.primaryColor,
          selectedItemColor: ColorPalette.accentColor,
          unselectedItemColor: ColorPalette.backgroundColor,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
