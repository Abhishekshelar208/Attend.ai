import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/ui/feedback.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text(
                "Attend.ai",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 30),
                          Text(
                            "Rules & Regulations",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              color: Color(0xFF101213),
                            ),
                          ),
                          SizedBox(height: 30),
                          _buildRuleItem('Rule 1: Ensure you are logged in to use the app.'),
                          _buildRuleItem('Rule 2: Location services must be enabled to mark attendance.'),
                          _buildRuleItem('Rule 3: Enter the correct code provided by your teacher.'),
                          _buildRuleItem('Rule 4: Do not close the app while processing attendance.'),
                          _buildRuleItem('Rule 5: Contact Developer if you face any issues.'),
                          // Add more rules as needed
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage(),));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4b39ef),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Feedback",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
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

  Widget _buildRuleItem(String rule) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            color: Colors.green.shade900,
            size: 22,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              rule,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
