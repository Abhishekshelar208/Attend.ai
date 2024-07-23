import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:krishna/Session_Manager/session_manager.dart';
import 'package:krishna/utils/utils.dart';

class CreateStudentID extends StatefulWidget {
  CreateStudentID({Key? key}) : super(key: key);

  @override
  State<CreateStudentID> createState() => _CreateStudentIDState();
}

class _CreateStudentIDState extends State<CreateStudentID> {
  final databaseRef = FirebaseDatabase.instance.ref('Student_ID_&_Password');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController studentIDController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();

  String? selectedBranch;
  String? selectedYear;

  final List<String> branches = [
    "Computer Engineering",
    "Information Technology",
    "Mechanical Engineering",
    "Civil Engineering",
    "Artificial Intelligence and Data Science"
  ];
  final List<String> years = ["First Year", "Second Year", "Third Year", "Final Year"];

  // List to store all student details
  List<Map<String, dynamic>> studentInfo = [];

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 700,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          child: Image.network(
                              "https://i.pinimg.com/736x/42/12/19/42121987e913a73ee9e656ce4060a77f.jpg"),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Student Registration",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Enter Full Name...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedYear,
                            items: years.map((String year) {
                              return DropdownMenuItem<String>(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedYear = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Select Year...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedBranch,
                            items: branches.map((String branch) {
                              return DropdownMenuItem<String>(
                                value: branch,
                                child: Text(branch),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedBranch = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Select Branch...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: rollNoController,
                            decoration: InputDecoration(
                              hintText: "Enter Roll No...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: studentIDController,
                            decoration: InputDecoration(
                              hintText: "Create Student ID...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Set Password...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Validate inputs
                            if (nameController.text.isEmpty ||
                                selectedYear == null ||
                                selectedBranch == null ||
                                rollNoController.text.isEmpty ||
                                studentIDController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              Utils().toastMessage("Please fill all fields.");
                              return;
                            }

                            try {
                              // Signup logic using Firebase Authentication
                              UserCredential userCredential = await _auth
                                  .createUserWithEmailAndPassword(
                                email: studentIDController.text.toString().toUpperCase() + "@gmail.com",
                                password: passwordController.text,
                              );

                              // Set user ID in session controller
                              SessionController().userId = userCredential.user!.uid.toString();

                              // Store user information in Firebase Realtime Database
                              await databaseRef.child(SessionController().userId!).set({
                                'id': SessionController().userId,
                                'Name': nameController.text.toString(),
                                'StudentID': studentIDController.text.toString().toUpperCase() + "@gmail.com",
                                'Password': passwordController.text.toString(),
                                'Roll No': rollNoController.text.toString(),
                                'Branch': selectedBranch,
                                'Year': selectedYear,
                              });

                              // On successful signup
                              Utils().toastMessage("Signup Successful");

                              // Navigate back to previous screen
                              Navigator.pop(context);
                            } catch (error) {
                              // Handle errors during signup
                              Utils().toastMessage("Signup Error: $error");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Register",
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
                          "Required Internet Connection.",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 35),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
