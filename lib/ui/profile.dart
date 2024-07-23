import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:krishna/Session_Manager/session_manager.dart';
import 'package:krishna/ui/auth/login_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Student_ID_&_Password');
  User? _user;
  String _displayName = '';
  String _studentID = '';
  String _branch = '';
  String _rollno = '';
  String _year = '';

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
          final data = snapshot.value as Map;
          _displayName = data['Name'] ?? 'No Name';
          _studentID = data['StudentID'] ?? 'No Student ID';
          _branch = data['Branch'] ?? 'No Branch';
          _rollno = data['Roll No'] ?? 'No Roll No';
          _year = data['Year'] ?? 'No Year';
        });
      } else {
        // Handle case where data doesn't exist
        setState(() {
          _displayName = 'No Name';
          _studentID = 'No Student ID';
          _branch = 'No Branch';
          _rollno = 'No Roll No';
          _year = 'No Year';
        });
      }
    }
  }

  void _logout(BuildContext context) {
    _auth.signOut().then((value) {
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange,
              Colors.purpleAccent,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          child: Image.network(
                            "https://i.pinimg.com/736x/42/12/19/42121987e913a73ee9e656ce4060a77f.jpg",
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "User Details",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildDetailRow("Name: ", _displayName),
                        _buildDetailRow("StudentID: ", _studentID),
                        _buildDetailRow("Roll No: ", _rollno),
                        _buildDetailRow("Branch: ", _branch),
                        _buildDetailRow("Year: ", _year),
                        const SizedBox(height: 20),
                        const Text(
                          "Note:",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text("Facing any issue with login, contact Developer."),
                        const SizedBox(height: 20),
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
        onPressed: () => _logout(context),
        backgroundColor: Colors.black,
        child: const Icon(Icons.logout, color: Colors.white),
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
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
