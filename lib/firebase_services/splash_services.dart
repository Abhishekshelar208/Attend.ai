import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:krishna/Session_Manager/session_manager.dart';
import 'package:krishna/ui/home_screen.dart';
import 'package:krishna/ui/auth/login_screen.dart';
import 'package:krishna/ui/home_screen_for_student.dart';
import 'package:krishna/ui/introscreen.dart';
import 'package:krishna/ui/splash_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
          () {
        final auth = FirebaseAuth.instance;
        final user = auth.currentUser;

        if (user != null) {
          SessionController().userId = user.uid.toString();
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
  }
}
