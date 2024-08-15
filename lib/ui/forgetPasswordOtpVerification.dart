// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:krishna/ui/home_screen.dart';
// import 'package:krishna/utils/utils.dart'; // Import the utility class
//
// class ForgetPasswordOtpVerification extends StatefulWidget {
//   const ForgetPasswordOtpVerification({super.key});
//
//   @override
//   State<ForgetPasswordOtpVerification> createState() => _ForgetPasswordOtpVerificationState();
// }
//
// class _ForgetPasswordOtpVerificationState extends State<ForgetPasswordOtpVerification> {
//   List<TextEditingController> controllers = List.generate(
//     4,
//         (index) => TextEditingController(),
//   );
//   final TextEditingController studentIdController = TextEditingController();
//   bool _codeSubmitted = false;
//   String? _verificationId;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('Student_ID_&_Password');
//
//   // Sends OTP to the user's phone number
//   void _sendOtp() async {
//     final String studentId = studentIdController.text.trim().toUpperCase() + '@gmail.com';
//
//     if (studentId.isEmpty) {
//       Utils().toastMessage('Please enter your student ID.');
//       return;
//     }
//
//     try {
//       // Query the database using the modified studentId
//       final snapshot = await _databaseRef.orderByChild('StudentID').equalTo(studentId).get();
//
//       if (snapshot.exists) {
//         final data = snapshot.children.first.value as Map?;
//         String phoneNumber = data?['PhoneNo'] ?? ''; // Fetch phone number
//
//         // Ensure phone number is in E.164 format
//         String countryCode = '+91'; // Adjust according to the user's country
//         String formattedPhoneNumber = countryCode + phoneNumber;
//
//         if (formattedPhoneNumber.isNotEmpty) {
//           await _auth.verifyPhoneNumber(
//             phoneNumber: formattedPhoneNumber,
//             verificationCompleted: (PhoneAuthCredential credential) async {
//               // Auto-sign-in or instant verification
//               await _auth.signInWithCredential(credential);
//             },
//             verificationFailed: (FirebaseAuthException e) {
//               // Handle errors here
//               Utils().toastMessage('Verification failed: ${e.message}');
//             },
//             codeSent: (String verificationId, int? resendToken) {
//               setState(() {
//                 _verificationId = verificationId;
//               });
//             },
//             codeAutoRetrievalTimeout: (String verificationId) {
//               setState(() {
//                 _verificationId = verificationId;
//               });
//             },
//           );
//         } else {
//           Utils().toastMessage('Phone number not found.');
//         }
//       } else {
//         Utils().toastMessage('Student ID not found.');
//       }
//     } catch (e) {
//       Utils().toastMessage('Error sending OTP: ${e.toString()}');
//     }
//   }
//
//   // Verifies the entered OTP
//   void _submitCode() async {
//     if (_codeSubmitted) return; // Prevent multiple submissions
//
//     String enteredCode = controllers.map((controller) => controller.text).join();
//     if (_verificationId != null) {
//       try {
//         final credential = PhoneAuthProvider.credential(
//           verificationId: _verificationId!,
//           smsCode: enteredCode,
//         );
//
//         // Sign in with the credential
//         await _auth.signInWithCredential(credential);
//
//         // Navigate to the next page
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your actual next page
//         );
//       } catch (e) {
//         // Handle invalid OTP error
//         Utils().toastMessage('Invalid OTP. Please try again: ${e.toString()}');
//       }
//     } else {
//       Utils().toastMessage('Verification ID is null. Please request OTP again.');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.orange,
//               Colors.purpleAccent,
//             ],
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Enter OTP",
//               style: TextStyle(
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: TextFormField(
//                 controller: studentIdController,
//                 decoration: InputDecoration(
//                     hintText: "Enter Student ID...",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(
//                           color: Colors.black,
//                         ))),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Enter Student ID...';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(
//                 4,
//                     (index) => SizedBox(
//                   width: 50,
//                   height: 70,
//                   child: TextField(
//                     controller: controllers[index],
//                     textAlign: TextAlign.center,
//                     keyboardType: TextInputType.number,
//                     maxLength: 1,
//                     enabled: !_codeSubmitted,
//                     decoration: InputDecoration(
//                       counter: Offstage(),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onChanged: (value) {
//                       if (value.length == 1 && index < 3) {
//                         FocusScope.of(context).nextFocus();
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _sendOtp,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: const Text(
//                 "Send OTP",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: _submitCode,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: const Text(
//                 "Submit",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
