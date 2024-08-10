import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedIntroduction(
        slides: const [
          SingleIntroScreen(
            title: 'Welcome',
            description: 'Welcome to Hydroponic App',
            imageAsset: 'assets/onboard_one.png', // Replace with your asset
          ),
          SingleIntroScreen(
            title: 'Monitor Your Plants',
            description: 'Keep track of all essential parameters',
            imageAsset: 'assets/onboard_one.png', // Replace with your asset
          ),
          SingleIntroScreen(
            title: 'Get Insights',
            description: 'Analyze the data and optimize your system',
            imageAsset: 'assets/onboard_one.png', // Replace with your asset
          ),
        ],
        onDone: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        },
      ),
    );
  }
}
