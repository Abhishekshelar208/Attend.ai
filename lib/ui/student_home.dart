import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:krishna/ui/add_attendance.dart';
import 'package:krishna/ui/like.dart';
import 'package:krishna/utils/utils.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Attendance');

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData(); // Load data method (replace with your actual Firebase data fetch)
  }

  void loadData() {
    // Simulate data loading delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Set loading to false when data is fetched
      });
    });
  }

  void _showActivateDialog(String date, String lectureName) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ActivateDialog(date: date, lectureName: lectureName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          "Attendance Pro",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
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
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (context, snapshot, animation, index) {
            if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>?) {
              Map<dynamic, dynamic>? attendance = snapshot.value as Map<dynamic, dynamic>?;

              if (attendance == null) {
                return SizedBox.shrink();
              }

              attendance['key'] = snapshot.key ?? '';

              DateTime date;
              String lectureName;
              bool isDeactivated = attendance['DeActivated'] ?? false;
              try {
                date = DateTime.parse(attendance['Date'] ?? DateTime.now().toString());
              } catch (e) {
                date = DateTime.now();
              }
              lectureName = attendance['Lecture Name'] ?? 'Unknown Lecture';

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        DateFormat('dd-MM-yyyy').format(date),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(lectureName),
                      trailing: ElevatedButton(
                        onPressed: isDeactivated ? null : () {
                          _showActivateDialog(
                            DateFormat('dd-MM-yyyy').format(date),
                            lectureName,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDeactivated ? Colors.red : Colors.green,
                        ),
                        child: Text(
                          isDeactivated ? "Closed" : "Join",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}



class ActivateDialog extends StatefulWidget {
  final String date;
  final String lectureName;

  const ActivateDialog({
    Key? key,
    required this.date,
    required this.lectureName,
  }) : super(key: key);

  @override
  _ActivateDialogState createState() => _ActivateDialogState();
}

class _ActivateDialogState extends State<ActivateDialog> {
  late Timer _timer;
  int _counter = 10;
  bool _codeSubmitted = false;
  List<TextEditingController> controllers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          timer.cancel();
          _showResult('Processing');
        }
      });
    });
  }

  void _submitCode() async {
    if (_codeSubmitted) return; // Prevent multiple submissions
    String enteredCode = controllers.map((controller) => controller.text).join();

    DatabaseReference activationRef = FirebaseDatabase.instance.ref('Activation Codes/CodeArray');
    try {
      DatabaseEvent event = await activationRef.once();
      DataSnapshot snapshot = event.snapshot;
      dynamic codeArray = snapshot.value;
      if (codeArray != null && codeArray is List) {
        if (codeArray.contains(enteredCode)) {
          await _storeRollNumber();
          _showResult("Processing");
        } else {
          Utils().toastMessage('Invalid Code');
        }
      } else {
        Utils().toastMessage('Activation codes not found');
      }
    } catch (error) {
      print('Error retrieving activation codes: $error');
      Utils().toastMessage('Error occurred. Please try again later.');
    }
  }

  Future<void> _storeRollNumber() async {
    try {
      DatabaseReference userRef = FirebaseDatabase.instance.ref('Student_ID_&_Password/${FirebaseAuth.instance.currentUser?.uid}');
      DataSnapshot userSnapshot = await userRef.once().then((event) => event.snapshot);
      if (userSnapshot.exists) {
        String? rollNumber = userSnapshot.child('Roll No').value as String?;
        if (rollNumber != null) {
          String key = '${widget.date}_${widget.lectureName}';
          DatabaseReference submittedDetailsRef = FirebaseDatabase.instance.ref('SubmitedDetails/$key/$rollNumber');
          await submittedDetailsRef.set({
            'RollNo': rollNumber,
            'Present': true,
          });
          Utils().toastMessage('Roll number stored successfully.');
        } else {
          Utils().toastMessage('Roll number not found.');
        }
      } else {
        Utils().toastMessage('User details not found.');
      }
    } catch (error) {
      print('Error storing roll number: $error');
      Utils().toastMessage('Error occurred. Please try again later.');
    }
  }


  void _showResult(String message) {
    setState(() {
      _codeSubmitted = true;
    });
    _timer.cancel();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 300,
            width: 370,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange,
                  Colors.purpleAccent,
                ],
              ),
            ),
            child: Center(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: 25), () {
      Navigator.pop(context); // Close dialog after 25 seconds
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300,
        width: 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange,
              Colors.purpleAccent,
            ],
          ),
        ),
        child: _codeSubmitted
            ? Center(
          child: Text(
            "Completed",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.date}_${widget.lectureName}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10, // Adjusted font size to 10
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '$_counter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                    (index) => SizedBox(
                  width: 50,
                  height: 70,
                  child: TextField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    enabled: !_codeSubmitted,
                    decoration: InputDecoration(
                      counter: Offstage(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _codeSubmitted ? null : _submitCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
