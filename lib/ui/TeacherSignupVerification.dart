import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/ui/create_teacher_id.dart';
import 'package:krishna/ui/developerHome.dart';
import 'package:krishna/ui/home_screen.dart';
import '../utils/utils.dart';
import 'homeScreenForDeveloper.dart'; // Make sure to replace with your actual Utils import

class TeacherSignupOTPVerification extends StatefulWidget {
  const TeacherSignupOTPVerification({super.key});

  @override
  State<TeacherSignupOTPVerification> createState() => _TeacherSignupOTPVerificationState();
}

class _TeacherSignupOTPVerificationState extends State<TeacherSignupOTPVerification> {
  List<TextEditingController> controllers = List.generate(
    4,
        (index) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );
  bool _codeSubmitted = false;

  void _submitCode() {
    if (_codeSubmitted) return; // Prevent multiple submissions
    String enteredCode = controllers.map((controller) => controller.text).join();

    if (enteredCode == "2080") {
      // Navigate to HomeScreen if code is correct
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateTeacherID()), // Replace with your actual HomeScreen
      );
    } else {
      // Show error message
      Utils().toastMessage('Invalid Code');
    }
  }

  @override
  void dispose() {
    // Dispose focus nodes and controllers
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onFieldChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF4b39ef),
              Color(0xFFee8b60),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.085),
              Text(
                "Attend.ai",
                style: TextStyle(
                  fontSize: screenWidth * 0.1,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    height: screenHeight * 0.35,
                    width:  screenWidth * 0.90,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(50), // Border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Enter Password",
                            style: TextStyle(
                              fontSize: screenWidth * 0.070,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.030),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              4,
                                  (index) => SizedBox(
                                width: screenWidth * 0.13,
                                height: screenHeight * 0.080,
                                child: TextField(
                                  obscureText: true,
                                  controller: controllers[index],
                                  focusNode: focusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  enabled: !_codeSubmitted,
                                  decoration: InputDecoration(
                                    counter: Offstage(),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (value) => _onFieldChanged(value, index),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.030),
                          SizedBox(
                            height: screenHeight * 0.050,
                            width: screenWidth * 0.7,
                            child: ElevatedButton(
                              onPressed: _codeSubmitted ? null : _submitCode,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _codeSubmitted
                                  ? SizedBox(
                                height: 28,
                                width: 28,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.050,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                ),
                              ),
                            ),

                          ),
                          SizedBox(height: screenHeight * 0.012),
                          Text(
                            "Only Teacher's Can Access",
                            style: TextStyle(
                              fontSize: screenWidth * 0.040,
                              fontWeight: FontWeight.w900,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              color: Colors.red.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
