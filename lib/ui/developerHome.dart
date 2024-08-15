import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';

class DeveloperHomePage extends StatefulWidget {
  const DeveloperHomePage({Key? key}) : super(key: key);

  @override
  State<DeveloperHomePage> createState() => _DeveloperHomePageState();
}

class _DeveloperHomePageState extends State<DeveloperHomePage> {
  final databaseRef = FirebaseDatabase.instance.ref('Improvements');
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showDeleteDialog(String key) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Feedback"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                databaseRef.child(key).remove().then((_) {
                  Utils().toastMessage('Feedback Deleted Successfully');
                  Navigator.of(context).pop();
                }).catchError((error) {
                  Utils().toastMessage('Failed to Delete Feedback: $error');
                });
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  void _showDetailsDialog(BuildContext context, String feedback, String suggestion) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 270,
            width: 370,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF4b39ef),
                  Color(0xFFee8b60),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Feedback Details',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Feedback:',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      feedback,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Suggestion:',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      suggestion,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
            children: [
              const SizedBox(height: 40),
              Text(
                "Developer.ai",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: _isLoading
                      ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                      : FirebaseAnimatedList(
                    query: databaseRef,
                    itemBuilder: (context, snapshot, animation, index) {
                      Map feedback = snapshot.value as Map;
                      feedback['key'] = snapshot.key;

                      String year = feedback['year'] ?? 'No Year';
                      String branch = feedback['branch'] ?? 'No Branch';
                      String rollno = feedback['rollno'] ?? 'No Roll No';
                      String division = feedback['division'] ?? 'No Division';
                      String feedbackText = feedback['feedback'] ?? 'No Feedback';
                      String suggestionText = feedback['suggestion'] ?? 'No Suggestion';

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$year - $branch',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$division - $rollno',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  _showDetailsDialog(
                                    context,
                                    feedbackText,
                                    suggestionText,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF39d2c0),
                                ),
                                child: Text(
                                  "Details",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              onLongPress: () {
                                _showDeleteDialog(snapshot.key!);
                              },
                            ),
                          ),
                        ),
                      );
                    },
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

