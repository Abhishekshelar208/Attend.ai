import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/Session_Manager/session_manager.dart';
import 'package:krishna/utils/utils.dart';

class CreateTeacherID extends StatefulWidget {
  CreateTeacherID({Key? key}) : super(key: key);

  @override
  State<CreateTeacherID> createState() => _CreateTeacherIDState();
}

class _CreateTeacherIDState extends State<CreateTeacherID> {
  final databaseRef = FirebaseDatabase.instance.ref('Teacher_ID_&_Password');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailIDController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController studentIDController = TextEditingController();





  bool isLoading = false;

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
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
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 620,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF101213),
                          ),
                        ),
                        Text(
                          "Let's get started by filling out the form",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF57636c),
                          ),
                        ),
                        Text(
                          "below",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF57636c),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(color: Color(0xFF57636c),
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: studentIDController,
                            decoration: InputDecoration(
                              hintText: "TeacherID",
                              hintStyle: TextStyle(color: Color(0xFF57636c),
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: emailIDController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Email ID",
                              hintStyle: TextStyle(color: Color(0xFF57636c),
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Color(0xFF57636c),
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validate inputs
                              if (nameController.text.isEmpty ||
                                  // selectedYear == null ||
                                  // selectedBranch == null ||
                                  // selectedDivision == null ||
                                  // rollNoController.text.isEmpty ||
                                  studentIDController.text.isEmpty ||
                                  emailIDController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                Utils().toastMessage("Please fill all fields.");
                                return;
                              }

                              setState(() {
                                isLoading = true;
                              });

                              try {
                                // Signup logic using Firebase Authentication
                                UserCredential userCredential = await _auth
                                    .createUserWithEmailAndPassword(
                                  email: emailIDController.text,
                                  password: passwordController.text,
                                );

                                // Set user ID in session controller
                                SessionController().userId = userCredential.user!.uid.toString();

                                // Store user information in Firebase Realtime Database
                                await databaseRef.child(SessionController().userId!).set({
                                  'id': SessionController().userId,
                                  'Name': nameController.text.toString(),
                                  'EmailID': emailIDController.text.toString(),
                                  // 'Roll No': rollNoController.text.toString(),
                                  // 'Branch': selectedBranch,
                                  // 'Year': selectedYear,
                                  // 'Division': selectedDivision,
                                  'TeacherID': studentIDController.text.toString().toUpperCase(),
                                });

                                // On successful signup
                                Utils().toastMessageBlue("Signup Successful");

                                setState(() {
                                  isLoading = false;
                                });

                                // Navigate back to previous screen
                                Navigator.pop(context);
                              } catch (error) {
                                setState(() {
                                  isLoading = false;
                                });
                                // Handle errors during signup
                                Utils().toastMessage("Signup Error: $error");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4b39ef),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? SizedBox(
                              height: 28, // height of the CircularProgressIndicator
                              width: 28, // width of the CircularProgressIndicator
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Note:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Required Internet Connection.",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
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
