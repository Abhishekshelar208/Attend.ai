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
              ]),
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
                const SizedBox(height: 40),
                Container(
                  height: 600,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF101213),
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        Text(
                          "Fill out the information below in order",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF57636c),
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        Text(
                          "to access your account.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF57636c),
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            width: 300,
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
                            width: 300,
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
                          width: 300,
                          height: 44,
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
                                fontSize: 20,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Or sign in with",
                          style: TextStyle(
                            color: Color(0xFF57636c),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Utils().toastMessageBlue('Coming Soon...');
                              },
                              icon: const Icon(
                                Icons.g_mobiledata,
                                color: Colors.black,
                                size: 30,
                              ),
                              label: Text(
                                "Continue with Google",
                                style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                Utils().toastMessageBlue('Coming Soon...');
                              },
                              icon: const Icon(
                                Icons.apple,
                                color: Colors.black,
                                size: 27,
                              ),
                              label: Text(
                                "Continue with Apple",
                                style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
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
    );
  }
}
