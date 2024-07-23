//lib/pages/main_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishna/ui/auth/login_screen.dart';
import 'package:krishna/ui/home_screen.dart';
import 'package:krishna/ui/home_screen_for_student.dart';
import 'package:krishna/ui/otpForTeacherVerification.dart';
import 'package:krishna/ui/student_verification.dart';
import 'package:krishna/ui/teacher_home.dart';
import 'package:krishna/ui/teacher_registration.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

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
                ])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Who Are You?",style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Otpforteacherverification(),));
            },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                ),
                child: Text("Teacher",style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),)),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenForStdudent(),));
            },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                ),
                child: Text("Student",style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),)),

          ],
        ),
      ),
    );
  }
}
