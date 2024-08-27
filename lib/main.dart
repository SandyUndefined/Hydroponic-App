import 'package:flutter/material.dart';
import 'package:hydrophonic/screens/intro_screen.dart';
import 'package:hydrophonic/utils/color_palette.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hydroponic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: ColorPalette.primaryColor,
          secondary: ColorPalette.secondaryColor,
          tertiary: ColorPalette.accentColor,
          background: ColorPalette.backgroundColor,
        ),
        scaffoldBackgroundColor: Colors.white,
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
      home: IntroScreen(),
    );
  }
}
