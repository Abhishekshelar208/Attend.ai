import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';
import 'package:krishna/ui/add_attendance.dart';
import 'dart:async';

import 'package:krishna/utils/utils.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  final List<int> activationCodes = [
    7632,
    8943,
    2623,
    9080,
    6565,
    4590,
    3434,
    8787,
    2187,
    3277,
    6677,
    4433,
    9988,
    6633,
    5645,
    5643,
    3434,
    5656,
    1254,
    4758,
    4783,
    8757,
    9834,
    4759,
    5489,
    8549,
    6162
  ];

  final databaseRef = FirebaseDatabase.instance.ref('Attendance');
  bool _isLoading = true;

  final DatabaseReference databaseRef2 =
  FirebaseDatabase.instance.ref('Activation Codes');

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showActivateDialog(String key, int activationCode) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ActivateDialog(
          activationCode: activationCode, // Pass activation code to ActivateDialog
          onTimerEnd: () {
            setState(() {
              databaseRef.child(key).update({
                'DeActivated': true,
              });
            });
          },
          onActivate: () {
            setState(() {
              Utils().toastMessage('Code Activated Successfully');
            });
          },

        );
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
            Map attendance = snapshot.value as Map;
            attendance['key'] = snapshot.key;

            DateTime date;
            String lectureName;
            bool activated = attendance['DeActivated'] ?? false;

            try {
              date = DateTime.parse(attendance['Date']);
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
                    trailing: activated
                        ? ElevatedButton(
                      onPressed: () {
                        Utils().toastMessage("Button is Closed...");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: Text(
                        "Closed",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        : ElevatedButton(
                      onPressed: () {
                        _showActivateDialog(
                            snapshot.key!, activationCodes[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        "Activate",
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
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Map<String, dynamic>? result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddAttendance()));
          if (result != null) {
            // Handle result from AddAttendance page if needed
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ActivateDialog extends StatefulWidget {
  final int activationCode;
  final VoidCallback? onTimerEnd;
  final VoidCallback? onActivate;

  const ActivateDialog({
    Key? key,
    required this.activationCode,
    this.onTimerEnd,
    this.onActivate,
  }) : super(key: key);

  @override
  _ActivateDialogState createState() => _ActivateDialogState();
}

class _ActivateDialogState extends State<ActivateDialog> {
  late Timer _timer;
  int _counter = 30; // Set initial countdown value to 60 seconds
  bool _activated = false; // Track if activated

  @override
  void initState() {
    super.initState();
    // Start the timer
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          timer.cancel();
          _activated = true; // Mark as permanently activated
          if (widget.onTimerEnd != null) {
            widget.onTimerEnd!(); // Notify parent widget
          }
        }
      });
    });
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
        height: 270,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _activated ? 'Deactivated' : '$_counter',
              // Display countdown timer or status
              style: TextStyle(
                color: _activated ? Colors.red : Colors.white,
                fontSize: _activated ? 24 : 80,
                fontWeight: _activated ? FontWeight.bold : FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Code: ${widget.activationCode}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _activated
                ? ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text(
                "Deactivated",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : ElevatedButton(
              onPressed: widget.onActivate != null ? widget.onActivate : null,
              // Disabled for timer dialog
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                "Activate",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
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

