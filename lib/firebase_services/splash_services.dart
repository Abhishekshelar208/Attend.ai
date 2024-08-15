// lib/firebase_services/splash_services.dart

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:krishna/ui/home_screen.dart';
import 'package:krishna/ui/auth/login_screen.dart';
import 'package:krishna/ui/introscreen.dart';

class SplashServices {
  void checkLoginStatus(BuildContext context) async {
    try {
      await Firebase.initializeApp(); // Ensure Firebase is initialized

      Timer(
        const Duration(seconds: 3),
            () {
          final auth = FirebaseAuth.instance;
          final user = auth.currentUser;

          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const IntroScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        },
      );
    } catch (e) {
      // Handle any errors during Firebase initialization
      print('Error initializing Firebase: $e');
      // You can show an error message or navigate to an error screen if needed
    }
  }
}
