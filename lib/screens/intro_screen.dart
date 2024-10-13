import 'package:animated_introduction/animated_introduction.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydrophonic/components/widgets/showGreetingDialog.dart';
import 'package:hydrophonic/utils/color_palette.dart';
import 'home_screen.dart';

class IntroScreen extends StatelessWidget {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> _handleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final User user = userCredential.user!;

        // Show the greeting dialog after login
        showGreetingDialog(context, user);

        return user;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedIntroduction(
        slides: const [
          SingleIntroScreen(
            title: 'Welcome',
            description: 'Welcome to Hydroponic App',
            imageAsset: 'assets/images/one_slide.png', // Replace with your asset
          ),
          SingleIntroScreen(
            title: 'Monitor Your Plants',
            description: 'Keep track of all essential parameters',
            imageAsset: 'assets/images/two_slide.png', // Replace with your asset
          ),
          SingleIntroScreen(
            title: 'Get Insights',
            description: 'Analyze the data and optimize your system',
            imageAsset: 'assets/images/third_slide.png', // Replace with your asset
          ),
        ],
        onDone: () async {
            // User? user = await _handleSignIn(context);
            // if (user != null) {
              // Delay navigation to allow time for the dialog to be shown
              // await Future.delayed(const Duration(seconds: 2));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            }
          //},
      ),
    );
  }
}
