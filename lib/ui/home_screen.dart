import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:krishna/ui/auth/login_screen.dart';
import 'package:krishna/ui/rules.dart';
import 'package:krishna/ui/search.dart';
import 'package:krishna/ui/profile.dart';
import 'package:krishna/ui/teacherProfile.dart';

import 'teacher_home.dart';
import 'like.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
      );
    });
  }

  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    TeacherHomePage(),
    LikePage(),
    RulesPage(),
    TeacherProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            onTabChange: _onItemTapped,
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.add_chart_rounded, text: "Attendance"),
              GButton(icon: Icons.hourglass_empty, text: "Rules"),
              GButton(icon: Icons.person, text: "Profile"),
            ],
          ),
        ),
      ),
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
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
