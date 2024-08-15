// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _createActivationCodes();
//           },
//           child: Text('Create Activation Codes'),
//         ),
//       ),
//     );
//   }
//
//   void _createActivationCodes() async {
//     try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//       // Define the list of codes
//       List<int> codes = [
//         7632, 8943, 2623, 9080, 6565, 4590, 3434, 8787, 2187, 3277,
//         6677, 4433, 9988, 6633, 5645, 5643, 3434, 5656, 1254, 4758,
//         4783, 8757, 9834, 4759, 5489, 8549, 6162
//       ];
//
//       // Add the list of codes to the Firestore document
//       await firestore.collection('Activation Codes').doc('CodeArray').set({
//         'codes': codes,
//       });
//
//       print('Activation Codes created successfully');
//     } catch (e) {
//       print('Error creating activation codes: $e');
//     }
//   }
// }
