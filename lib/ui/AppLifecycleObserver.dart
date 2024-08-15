// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:krishna/ui/auth/login_screen.dart';
//
// class AppLifecycleObserver extends StatefulWidget {
//   final Widget child;
//
//   const AppLifecycleObserver({required this.child, Key? key}) : super(key: key);
//
//   @override
//   _AppLifecycleObserverState createState() => _AppLifecycleObserverState();
// }
//
// class _AppLifecycleObserverState extends State<AppLifecycleObserver> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
//       _handleAppBackgrounded();
//     }
//     super.didChangeAppLifecycleState(state);
//   }
//
//   void _handleAppBackgrounded() async {
//     final auth = FirebaseAuth.instance;
//     final user = auth.currentUser;
//
//     if (user != null) {
//       // Log out the user
//       await auth.signOut();
//       // Redirect to the login screen
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//             (route) => false,
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
