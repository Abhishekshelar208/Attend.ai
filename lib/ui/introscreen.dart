import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/ui/home_screen_for_student.dart';
import 'package:krishna/ui/otpForTeacherVerification.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

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
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.050),
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
                    width:  screenWidth * 0.95,
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
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: screenWidth * 0.085,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              color: Color(0xFF101213),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.050),
                          SizedBox(
                            height: screenHeight * 0.045, // Set button height
                            width: screenWidth * 0.7,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Otpforteacherverification(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4b39ef),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Enter As Teacher',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.050,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.020),
                          SizedBox(
                            height: screenHeight * 0.045, // Set button height
                            width: screenWidth * 0.7,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreenForStdudent(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4b39ef),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Enter As Student',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.050,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                ),
                              ),
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
