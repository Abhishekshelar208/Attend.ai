import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CodeUploader extends StatefulWidget {
  @override
  _CodeUploaderState createState() => _CodeUploaderState();
}

class _CodeUploaderState extends State<CodeUploader> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('Activation Codes/CodeArray');

  @override
  void initState() {
    super.initState();
    _uploadCodes();
  }

  Future<void> _uploadCodes() async {
    List<String> codes = [
      '8237', '1496', '7364', '4829', '3915', '6498', '2374', '9156', '2847', '5932',
      '7483', '1629', '8394', '4927', '3861', '2748', '9601', '7432', '5148', '8796',
      '2547', '6203', '7381', '1987', '4652', '3079', '8412', '6750', '2398', '5834',
      '9702', '3648', '5123', '8471', '6942', '1308', '7265', '4953', '2846', '8701',
      '3469', '9275', '1834', '7906', '5624', '4813', '7391', '9028', '4716', '8527'
    ];

    try {
      // Set the list directly to the database
      await _databaseRef.set(codes);
      print('Codes uploaded successfully');
    } catch (error) {
      print('Error uploading codes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Codes')),
      body: Center(child: Text('Uploading Codes...')),
    );
  }
}
