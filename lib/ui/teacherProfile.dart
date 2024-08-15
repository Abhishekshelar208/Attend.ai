import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/Session_Manager/session_manager.dart';
import 'package:krishna/ui/auth/login_screen.dart';
import 'package:krishna/ui/developerInfo.dart';
import 'package:krishna/ui/editTeacherProfile.dart';
import 'package:krishna/ui/otpDeveloperVerification.dart';
import 'edit_profile_page.dart';

class TeacherProfilePage extends StatefulWidget {
  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Teacher_ID_&_Password');
  User? _user;
  String _displayName = '';
  String _studentID = '';
  String _email = '';     // New variable

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    _user = _auth.currentUser;
    if (_user != null) {
      final userId = _user!.uid;
      final snapshot = await databaseRef.child(userId).get();
      if (snapshot.exists) {
        setState(() {
          final data = snapshot.value as Map?;
          _displayName = data?['Name'] ?? 'No Name';
          _studentID = data?['TeacherID'] ?? 'No TeacherID';
          // _branch = data?['Branch'] ?? 'No Branch';
          // _rollno = data?['Roll No'] ?? 'No Roll No';
          // _year = data?['Year'] ?? 'No Year';
          // _division = data?['Division'] ?? 'No Division'; // Fetch Division
          _email = data?['EmailID'] ?? 'No EmailID';      // Fetch EmailID
        });
      } else {
        setState(() {
          _displayName = 'No Name';
          _studentID = 'No Teacher ID';
          // _branch = 'No Branch';
          // _rollno = 'No Roll No';
          // _year = 'No Year';
          // _division = 'No Division'; // Default Division
          _email = 'No EmailID';      // Default EmailID
        });
      }
    }
  }

  void _logout(BuildContext context) {
    _auth.signOut().then((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
      );
    });
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF101213),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildDetailRow("Name: ", _displayName),
                        _buildDetailRow("TeacherID: ", _studentID),
                        // _buildDetailRow("Roll No: ", _rollno),
                        // _buildDetailRow("Branch: ", _branch),
                        // _buildDetailRow("Year: ", _year),
                        // _buildDetailRow("Division: ", _division), // Display Division
                        _buildDetailRow("Email ID: ", _email),     // Display EmailID
                        const SizedBox(height: 20),
                        Text(
                          "Note:",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("Facing any issue with login, contact Developer.",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 400,
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4b39ef),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditTeacherProfilePage(
                                    displayName: _displayName,
                                    studentID: _studentID,
                                    // branch: _branch,
                                    // rollno: _rollno,
                                    // year: _year,
                                    // division: _division,   // Pass Division to EditProfilePage
                                    email: _email,         // Pass EmailID to EditProfilePage
                                    userId: _user!.uid,
                                  ),
                                ),

                              );
                            },
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              _logout(context);
                            },
                            child: Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DeveloperInfo(),));
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.adb, color: Colors.white,size: 32,),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
