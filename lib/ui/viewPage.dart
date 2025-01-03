import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/ui/CNAttendance.dart';
import 'package:krishna/ui/CN_DIV.dart';
import 'package:krishna/ui/DWMAttendance.dart';
import 'package:krishna/ui/DWM_DIV.dart';
import 'package:krishna/ui/IPAttendance.dart';
import 'package:krishna/ui/IP_DIV.dart';
import 'package:krishna/ui/PCEAttendance.dart';
import 'package:krishna/ui/PCE_DIV.dart';
import 'package:krishna/ui/SE_B_ATTENDANCE.dart';
import 'package:krishna/ui/SE_DIV.dart';
import 'package:krishna/ui/TCSAttendance.dart';
import 'package:krishna/ui/TCS_DIV.dart';
import 'package:krishna/ui/rules.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ViewPage(),
  ));
}

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final List<List<Color>> _gradientColors = [
    [Color(0xFF4b39ef), Color(0xFFee8b60)],
    [Color(0xFFee8b60), Color(0xFF4b39ef)],
  ];

  int _currentGradientIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentGradientIndex =
            (_currentGradientIndex + 1) % _gradientColors.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Getting screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: _gradientColors[_currentGradientIndex],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),
              Text(
                "Attendance Sheet",
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: screenHeight * 0.20),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SE_DIV(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.28,
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "SE",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts
                                            .plusJakartaSans()
                                            .fontFamily,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TCS_DIV(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "TCS",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts
                                            .plusJakartaSans()
                                            .fontFamily,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 17),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DWM_DIV(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "DWM",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts
                                            .plusJakartaSans()
                                            .fontFamily,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IP_DIV(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.28,
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "IP",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts
                                            .plusJakartaSans()
                                            .fontFamily,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 17),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CN_DIV(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.28,
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "CN",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts
                                            .plusJakartaSans()
                                            .fontFamily,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PCE_DIV(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "PCE",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts
                                            .plusJakartaSans()
                                            .fontFamily,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

