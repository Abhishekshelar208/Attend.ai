



import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:krishna/ui/add_attendance.dart';
import 'dart:async';
import 'package:getwidget/getwidget.dart';


import 'package:krishna/utils/utils.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> with SingleTickerProviderStateMixin {
  final List<int> activationCodes = [
    8237, 1496, 7364, 4829, 3915, 6498, 2374, 9156, 2847, 5932,
    7483, 1629, 8394, 4927, 3861, 2748, 9601, 7432, 5148, 8796,
    2547, 6203, 7381, 1987, 4652, 3079, 8412, 6750, 2398, 5834,
    9702, 3648, 5123, 8471, 6942, 1308, 7265, 4953, 2846, 8701,
    3469, 9275, 1834, 7906, 5624, 4813, 7391, 9028, 4716, 8527

  ];

  final databaseRef = FirebaseDatabase.instance.ref('Attendance');
  bool _isLoading = true;
  late TabController _tabController;
  String _selectedDivision = 'A'; // Default division

  final DatabaseReference databaseRef2 =
  FirebaseDatabase.instance.ref('Activation Codes');

  @override
  void initState() {
    super.initState();
    loadData();
    //_getStudentLocation(); // Fetch student location on init
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedDivision = _tabController.index == 0 ? 'A' : 'B';
      });
    });
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

  void _showDeleteDialog(String key) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Attendance",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),),
          content: Text("Are you sure you want to delete this item?",style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("No",style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),),
            ),
            TextButton(
              onPressed: () {
                databaseRef.child(key).remove().then((_) {
                  Utils().toastMessage('Attendance Deleted Successfully');
                  Navigator.of(context).pop();
                }).catchError((error) {
                  Utils().toastMessage('Failed to Delete Attendance: $error');
                });
              },
              child: Text("Yes",style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),),
            ),
          ],
        );
      },
    );
  }

  void _checkLocationAndShowDialog(String date, String lectureName, String attendanceKey) {
    // Your location check logic here

    // Show the activation dialog if the location check passes
    _showActivateDialog(attendanceKey, activationCodes[0]); // Example, replace activationCodes[0] with actual logic
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF4b39ef),
              Color(0xFFee8b60),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                "Attend.ai",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(text: 'Division A'),
                          Tab(text: 'Division B'),
                        ],
                        indicatorColor: Colors.black,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildAttendanceList('A'),
                            _buildAttendanceList('B'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
  @override
  Widget _buildAttendanceList(String division) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      )
          : FirebaseAnimatedList(
        query: databaseRef.orderByChild('Division').equalTo(division),
        //query: databaseRef,
        itemBuilder: (context, snapshot, animation, index) {
          Map attendance = snapshot.value as Map;
          attendance['key'] = snapshot.key;

          DateTime date;
          String lectureName;
          String division;
          bool activated = attendance['DeActivated'] ?? false;

          try {
            date = DateTime.parse(attendance['Date']);
          } catch (e) {
            date = DateTime.now();
          }
          lectureName = attendance['Lecture Name'] ?? 'Unknown Lecture';
          division = attendance['Division'] ?? 'Unknown Division'; // Add this line

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
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                  ),
                  title: Text(
                    DateFormat('dd-MM-yyyy').format(date),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lectureName),
                      Text(division), // Display division here
                    ],
                  ),
                  trailing: activated
                      ? ElevatedButton(
                    onPressed: () {
                      Utils().toastMessage("Button is Closed...");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                    ),
                    child: Text(
                      "Closed",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                  )
                      : ElevatedButton(
                    onPressed: () {
                      _showActivateDialog(
                          snapshot.key!, activationCodes[index]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF39d2c0),
                    ),
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                  ),
                  onLongPress: () {
                    _showDeleteDialog(snapshot.key!);
                  },
                ),
              ),
            ),
          );
        },
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
  int _counter = 20; // Set initial countdown value to 60 seconds
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
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF4b39ef),
              Color(0xFFee8b60),
              //Color(0xFF39d2c0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _activated ? 'Deactivated' : '$_counter',
                // Display countdown timer or status
                style: TextStyle(
                  color: _activated ? Colors.red.shade300 : Colors.white60,
                  fontSize: _activated ? 24 : 80,
                  fontWeight: _activated ? FontWeight.bold : FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Code: ${widget.activationCode}',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
              SizedBox(height: 20),
              _activated
                  ? ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'DeActivated',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),
              )
                  : ElevatedButton(
                onPressed: () {
                  if (widget.onActivate != null) {
                    widget.onActivate!(); // Notify parent widget
                  }
                  //Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Activated',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),
              ),
            ],
          ),

        ),

      ),

    );

  }

}

