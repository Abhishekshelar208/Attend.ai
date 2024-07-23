import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:krishna/ui/create_student_id.dart';
import 'package:krishna/ui/home_screen.dart';
import 'package:krishna/ui/home_screen_for_student.dart';
import 'package:krishna/ui/student_home.dart'; // Update the import path as needed

class StudentVerification extends StatefulWidget {
  const StudentVerification({Key? key}) : super(key: key);

  @override
  State<StudentVerification> createState() => _StudentVerificationState();
}

class _StudentVerificationState extends State<StudentVerification> {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('FinalStudentDetails');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController teacherIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    teacherIDController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loginTeacher() {
    if (_formKey.currentState!.validate()) {
      String teacherID = teacherIDController.text.trim();
      String password = passwordController.text.trim();

      databaseRef
          .orderByChild('StudentID')
          .equalTo(teacherID)
          .once()
          .then((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        dynamic values = snapshot.value;

        if (values != null && values is Map) {
          values.forEach((key, value) {
            if (value is Map && value['Password'] == password) {
              // Login successful
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreenForStdudent()),
              );
              return;
            }
          });

          // Password incorrect or student ID not found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid Student ID or Password')),
          );
        } else {
          // Student ID not found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Student ID not found')),
          );
        }
      })
          .onError((error, stackTrace) {
        // Handle database query error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange,
              Colors.purpleAccent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verification",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 580,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 60,
                        child: Image.network(
                            "https://i.pinimg.com/736x/42/12/19/42121987e913a73ee9e656ce4060a77f.jpg"),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Student ID",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: teacherIDController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Student ID';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Student ID...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter Password...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _loginTeacher,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Note:",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Don't have Student ID? Create a new one.",
                      ),
                      SizedBox(height: 35),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateStudentID()),
                          );
                        },
                        child: Text(
                          "Create ID",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
