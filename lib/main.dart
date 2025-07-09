// lib/main.dart



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishna/ui/splash_screen.dart';

import 'firebase_options.dart';
import 'gsheets/gsheet_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GsheetIntit();     //this line is for google sheet
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}




//for a quick attendance

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
//
// import 'attendance/StudentAttendanceScreen.dart';
// import 'attendance/home_screen.dart';
// import 'firebase_options.dart'; // Import your screen
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform
//   );
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Quick Attendance',
//       onGenerateRoute: (settings) {
//         Uri uri = Uri.parse(settings.name ?? '');
//         if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'session') {
//           String sessionId = uri.pathSegments[1];
//           return MaterialPageRoute(
//             builder: (context) => StudentAttendanceScreen(sessionId: sessionId),
//           );
//         }
//         return MaterialPageRoute(builder: (context) => HomeScreen()); // Default screen
//       },
//     );
//   }
// }
