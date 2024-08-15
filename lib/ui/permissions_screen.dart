import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/ui/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final status = await [
      Permission.locationWhenInUse,
      Permission.notification,
      Permission.camera, // Add other permissions as needed
    ].request();

    // Check if all required permissions are granted
    bool allPermissionsGranted = status.values.every((status) => status.isGranted);

    // Navigate to SplashScreen after permissions are handled
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF4b39ef),
              Color(0xFFee8b60),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Attend.ai",
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//lib/assets/images/splashAnimation.gif