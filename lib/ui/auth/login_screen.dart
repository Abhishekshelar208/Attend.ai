import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishna/ui/auth/signup_screen.dart';
import 'package:krishna/ui/home_screen.dart';
import 'package:krishna/ui/home_screen_for_student.dart';
import 'package:krishna/ui/introscreen.dart';
import 'package:krishna/ui/student_home.dart';
import '../../Session_Manager/session_manager.dart';
import '../../utils/utils.dart';
import '../create_student_id.dart';

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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    _auth.signInWithEmailAndPassword(
        email: '${emailController.text.toString()}@gmail.com',
        password: passwordController.text.toString()
    ).then((value) {
      SessionController().userId = value.user!.uid.toString();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const IntroScreen()));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
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
              ]),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Login Page",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          child: Image.network(
                              "https://i.pinimg.com/736x/42/12/19/42121987e913a73ee9e656ce4060a77f.jpg"),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Email Id",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: "Enter Email ID...",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email...';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Enter Password...",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password...';
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        const SizedBox(height: 20),
                        const Text(
                          "Note:",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(height: 5),
                        const Text("This App is for Attendance Purpose only."),
                        const SizedBox(height: 20),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateStudentID()));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
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
