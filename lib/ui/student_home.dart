//this is my final student home page with working tabbar for seperation of division.


import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:krishna/utils/utils.dart';
import 'package:geolocator/geolocator.dart'; // Import geolocator for location services

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> with SingleTickerProviderStateMixin {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Attendance');

  bool _isLoading = true;
  Position? _studentLocation; // Store student's location
  late TabController _tabController;
  String _selectedDivision = 'A'; // Default division
  String? _userDivision;

  @override
  void initState() {
    super.initState();
    loadData();
    _getUserDivision(); // Fetch user's division
    //_getStudentLocation(); // Fetch student location on init
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedDivision = _tabController.index == 0 ? 'A' : 'B';
      });
    });
  }

  Future<void> _getUserDivision() async {
    DatabaseReference userRef = FirebaseDatabase.instance.ref('Student_ID_&_Password/${FirebaseAuth.instance.currentUser?.uid}');
    DatabaseEvent userEvent = await userRef.once();
    DataSnapshot userSnapshot = userEvent.snapshot;

    if (userSnapshot.exists) {
      _userDivision = userSnapshot.child('Division').value as String?;
    }
  }

  void loadData() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showActivateDialog(String date, String lectureName, String divisionName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ActivateDialog(date: date, lectureName: lectureName, divisionName: divisionName,);
      },
    );
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
    );
  }

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
            String attendanceKey = snapshot.key ?? ''; // Ensure you are using snapshot.key here

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Color(0xFFe0e3e7),
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
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      lectureName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: isDeactivated
                          ? null
                          : () {
                        if (_userDivision == division) {
                          _showActivateDialog(
                            DateFormat('dd-MM-yyyy').format(date),
                            lectureName,
                            division,
                          );
                        } else {
                          Utils().toastMessage('Division does not match. Please check your assigned division.');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDeactivated ? Colors.red : Color(0xFF39d2c0),
                      ),
                      child: Text(
                        isDeactivated ? "Closed" : "Join",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
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
    );
  }
}







class ActivateDialog extends StatefulWidget {
  final String date;
  final String lectureName;
  final String divisionName;


  const ActivateDialog({
    Key? key,
    required this.date,
    required this.lectureName,
    required this.divisionName,

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
  List<FocusNode> focusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    controllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          timer.cancel();
          _showLoadingDialog();
        }
      });
    });
  }


  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loading'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Please wait...')
            ],
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context, rootNavigator: true).pop(); // Close loading dialog
      Navigator.of(context).pop(); // Close activate dialog
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
          _showResult("To view Attendance -> 2nd Tab");
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
      DatabaseEvent userEvent = await userRef.once();
      DataSnapshot userSnapshot = userEvent.snapshot;

      if (userSnapshot.exists) {
        String? studentId = userSnapshot.child('StudentID').value as String?;
        String? RollNo = userSnapshot.child('Roll No').value as String?;
        if (studentId != null) {
          String key = '${widget.date}_${widget.lectureName}_${widget.divisionName}';
          DatabaseReference submittedDetailsRef = FirebaseDatabase.instance.ref('SubmitedDetails/$key/$studentId');
          await submittedDetailsRef.set({
            'StudentID': studentId,
            'Roll No': RollNo,
            'Present': true,
          });
          Utils().toastMessageBlue("Attendance Marked Successfully.");
          Navigator.of(context).pop(); // Close dialog
        }
      } else {
        Utils().toastMessage('User not found');
      }
    } catch (error) {
      print('Error storing roll number: $error');
      Utils().toastMessage('Error occurred. Please try again later.');
    }
  }

  void _showResult(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text(
            'Attendance Marked',
            style: TextStyle(
              fontSize: screenWidth * 0.060,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: Colors.green.shade500,
            ),
          ),
          content: Text(message,style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            color: Colors.black,
          ),),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },

    );
  }


  void _onTextChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Make the background transparent
      child: Stack(
        children: [
          Container(

            height: 330,
            width: 370,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4b39ef),
                  Color(0xFFee8b60),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(12), // Optional: to round the corners
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$_counter',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ensure the text is readable on the gradient
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Enter Code:',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white, // Ensure the text is readable on the gradient
                  ),

                ),
                SizedBox(height: 10),
                Row(
                  children: List.generate(4, (index) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: TextField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none// Change this to adjust the corner radius
                            ),
                            filled: true,
                            fillColor: Colors.white60, // Background color for text fields
                          ),
                          onChanged: (value) => _onTextChanged(index, value),
                        ),

                      ),
                    );
                  }),
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _submitCode,
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
