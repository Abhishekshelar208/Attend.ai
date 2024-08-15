import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:krishna/utils/utils.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _suggestionController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('Improvements');

  String rollno = '';
  String branch = '';
  String division = '';
  String year = '';

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    User? user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userRef = FirebaseDatabase.instance.ref('Student_ID_&_Password').child(userId);

      try {
        final snapshot = await userRef.get();
        if (snapshot.exists) {
          final data = snapshot.value as Map?;
          setState(() {
            rollno = data?['Roll No'] ?? 'No Roll No';
            branch = data?['Branch'] ?? 'No Branch';
            division = data?['Division'] ?? 'No Division';
            year = data?['Year'] ?? 'No Year';
          });
        }
      } catch (e) {
        // Handle errors, e.g., show a message to the user
      }
    }
  }

  void _sendFeedback(BuildContext context) async {
    String feedback = _feedbackController.text.trim();
    String suggestion = _suggestionController.text.trim();

    if (feedback.isEmpty && suggestion.isEmpty) {
      Utils().toastMessage('Please provide feedback or suggestion.');
      return;
    }

    try {
      // Generate a new key for each feedback entry
      final newFeedbackRef = _databaseRef.push();

      await newFeedbackRef.set({
        'Feedback Id': DateTime.now().millisecondsSinceEpoch.toString(),
        'feedback': feedback,
        'suggestion': suggestion,
        'rollno': rollno,
        'branch': branch,
        'division': division,
        'year': year,
      });

      Utils().toastMessageBlue('Feedback sent to the developer.');
      Navigator.pop(context);

      // Clear the text fields
      _feedbackController.clear();
      _suggestionController.clear();
    } catch (e) {
      Utils().toastMessageBlue('Failed to send feedback');
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
                            "Feedback",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              color: Color(0xFF101213),
                            ),
                          ),
                          Text(
                            "Write your feedback about the application and",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              color: Color(0xFF57636c),
                            ),
                          ),
                          Text(
                            "your experience.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              color: Color(0xFF57636c),
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: _feedbackController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "Write Your Feedback",

                                hintStyle: TextStyle(color: Color(0xFF57636c),

                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF1F4F8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: _suggestionController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "Write Your Suggestion",
                                hintStyle: TextStyle(color: Color(0xFF57636c),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF1F4F8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () => _sendFeedback(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4b39ef),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Send To Developer",
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
}
