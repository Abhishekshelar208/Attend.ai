import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/ui/rules.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: IP_B_ATTENDANCE(),
  ));
}

class IP_B_ATTENDANCE extends StatefulWidget {
  const IP_B_ATTENDANCE({Key? key}) : super(key: key);

  @override
  State<IP_B_ATTENDANCE> createState() => _IP_B_ATTENDANCEState();
}

class _IP_B_ATTENDANCEState extends State<IP_B_ATTENDANCE> {
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

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
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
                "INTERNET",
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: Colors.black54,
                ),
              ),
              Text(
                "PROGRAMMING",
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
                                onTap: () => _launchUrl('https://script.google.com/macros/s/AKfycbxmT5jrj1lHjQhIP-kRcml_b5vdI0ZH4XT17dsQSDUkcDyP5e-hBZm_ybZtp2-3kDsL/exec'),
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.75,
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "UPDATE  SHEET",
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
                                onTap: () => _launchUrl('https://docs.google.com/spreadsheets/d/16eagdc0pnkBbaDaZbXUGinZO2YkkRZldNJTAleHoazc/edit?gid=881536600#gid=881536600'),
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.75,
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "VIEW  SHEET",
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
