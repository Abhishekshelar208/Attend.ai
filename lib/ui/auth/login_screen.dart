import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/ui/auth/signup_screen.dart';
import 'package:krishna/ui/forgetpasswordscreen.dart';
import 'package:krishna/ui/home_screen.dart';
import 'package:krishna/ui/home_screen_for_student.dart';
import 'package:krishna/ui/introscreen.dart';
import 'package:krishna/ui/student_home.dart';
import '../../Session_Manager/session_manager.dart';
import '../../utils/utils.dart';
import '../create_student_id.dart';
import '../forgetPasswordOtpVerification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      _auth
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        setState(() {
          isLoading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const IntroScreen()));
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        Utils().toastMessage(error.toString());
      });
    }
  }

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
              ]),
        ),
        child: SingleChildScrollView(

          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.08,
              horizontal: screenWidth * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.030),
                Text(
                  "Attend.ai",
                  style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.060),
                Container(
                  height: screenHeight * 0.65,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.030,),
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: screenWidth * 0.080,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF101213),
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        Text(
                          "Fill out the information below in order",
                          style: TextStyle(
                            fontSize: screenWidth * 0.034,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF57636c),
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        Text(
                          "to access your account.",
                          style: TextStyle(
                            fontSize: screenWidth * 0.034,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF57636c),
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            width: screenWidth * 0.7,
                            child: TextFormField(
                              controller: emailController,
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
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            width: screenWidth * 0.7,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
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
                        ),
                        SizedBox(
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.045,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
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
                              height: 28,
                              width: 28,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.050,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPasswordScreen()));
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        Text(
                          "Or sign in with",
                          style: TextStyle(
                            color: Color(0xFF57636c),
                            fontSize: screenWidth * 0.040,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        SingleChildScrollView(
                          //scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ElevatedButton.icon(
                              //   onPressed: () {
                              //     Utils().toastMessageBlue('Coming Soon...');
                              //   },
                              //   icon: const Icon(
                              //     Icons.g_mobiledata,
                              //     color: Colors.black,
                              //     size: 30,
                              //   ),
                              //   label: Text(
                              //     "Continue with Google",
                              //     style: TextStyle(color: Colors.black,
                              //       fontWeight: FontWeight.w600,
                              //       fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              //       fontSize: screenWidth * 0.030,
                              //     ),
                              //   ),
                              //   style: ElevatedButton.styleFrom(
                              //     foregroundColor: Colors.black,
                              //     backgroundColor: Colors.white,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: screenHeight * 0.050),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateStudentID()));
                                },
                                child: Text(
                                  "Don't have an account? Sign Up here",
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontSize: screenWidth * 0.040,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                  ),
                                ),
                              ),
                            ],
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
    );
  }
}
