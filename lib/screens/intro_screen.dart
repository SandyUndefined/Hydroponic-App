import 'package:animated_introduction/animated_introduction.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class IntroScreen extends StatelessWidget {
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (error) {
      print(error);
      return null;
    }
  }

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
        onDone: () async {
          User? user = await _handleSignIn();
          if (user != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        },
      ),
    );
  }
}
