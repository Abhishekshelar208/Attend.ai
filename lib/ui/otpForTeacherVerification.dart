import 'dart:async';
import 'package:flutter/material.dart';
import 'package:krishna/ui/home_screen.dart';
//import 'package:your_app/utils/utils.dart';

import '../utils/utils.dart'; // Make sure to replace with your actual Utils import

class Otpforteacherverification extends StatefulWidget {
  const Otpforteacherverification({super.key});

  @override
  State<Otpforteacherverification> createState() => _OtpforteacherverificationState();
}

class _OtpforteacherverificationState extends State<Otpforteacherverification> {
  List<TextEditingController> controllers = List.generate(
    4,
        (index) => TextEditingController(),
  );
  bool _codeSubmitted = false;

  void _submitCode() {
    if (_codeSubmitted) return; // Prevent multiple submissions
    String enteredCode = controllers.map((controller) => controller.text).join();

    if (enteredCode == "8488") {
      // Navigate to HomeScreen if code is correct
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your actual HomeScreen
      );
    } else {
      // Show error message
      Utils().toastMessage('Invalid Code');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange,
              Colors.purpleAccent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Teacher Code",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                    (index) => SizedBox(
                  width: 50,
                  height: 70,
                  child: TextField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    enabled: !_codeSubmitted,
                    decoration: InputDecoration(
                      counter: Offstage(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _codeSubmitted ? null : _submitCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
