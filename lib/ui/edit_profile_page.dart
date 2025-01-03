import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  final String displayName;
  final String studentID;
  final String branch;
  final String division;
  final String rollno;
  final String year;
  final String email;
  final String userId;

  EditProfilePage({
    required this.displayName,
    required this.studentID,
    required this.branch,
    required this.division,
    required this.rollno,
    required this.year,
    required this.email,
    required this.userId,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String _displayName;
  late String _studentID;
  late String _branch;
  late String _division;
  late String _rollno;
  late String _year;
  late String _email;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Student_ID_&_Password');

  @override
  void initState() {
    super.initState();
    _displayName = widget.displayName;
    _studentID = widget.studentID;
    _branch = widget.branch;
    _division = widget.division;
    _rollno = widget.rollno;
    _year = widget.year;
    _email = widget.email;
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      databaseRef.child(widget.userId).update({
        'Name': _displayName,
        'StudentID': _studentID,
        'Branch': _branch,
        'Division': _division,
        'Roll No': _rollno,
        'Year': _year,
        'EmailID': _email,
      }).then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $error')),
        );
      });
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
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              "Edit Profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF101213),
                              ),
                            ),
                            SizedBox(height: 10),
                            buildTextFormField('Name', _displayName, (value) => _displayName = value ?? '', true),
                            buildTextFormField('Student ID', _studentID, (value) => _studentID = value ?? '', false),
                            buildTextFormField('Branch', _branch, (value) => _branch = value ?? '', false),
                            buildTextFormField('Division', _division, (value) => _division = value ?? '', false),
                            buildTextFormField('Roll No', _rollno, (value) => _rollno = value ?? '', false), // Roll No field is disabled
                            buildTextFormField('Year', _year, (value) => _year = value ?? '', false),
                            buildTextFormField('Email ID', _email, (value) => _email = value ?? '', false), // Email field is disabled
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: ElevatedButton(
                                onPressed: _saveProfile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF4b39ef),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(String hint, String initialValue, void Function(String?) onSaved, bool isEditable) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF57636c)),
          filled: true,
          fillColor: Color(0xFFF1F4F8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.all(16),
        ),
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hint';
          }
          return null;
        },
        enabled: isEditable,
      ),
    );
  }
}
