import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void showGreetingDialog(BuildContext context, User user) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Welcome'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL ?? ''),
                radius: 40,
              ),
              const SizedBox(height: 20),
              Text(
                'Hello, ${user.displayName}!',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  });
}
