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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
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
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.05,
              horizontal: screenWidth * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.050),
                Text(
                  "Attend.ai",
                  style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.050),
                Container(
                  height: screenHeight * 0.67,
                  width:  screenWidth * 0.92,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.025),
                        Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: screenWidth * 0.085,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF101213),
                          ),
                        ),
                        Text(
                          "Let's get started by filling out the form",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF57636c),
                          ),
                        ),
                        Text(
                          "below",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF57636c),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.020),
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
                        SizedBox(height: screenHeight * 0.020),
                        SizedBox(
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.045,
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
                                fontSize: screenWidth * 0.047,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        Text(
                          "Note:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          "Required Internet Connection.",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: screenWidth * 0.034,
                            fontWeight: FontWeight.w900,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.020),
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
