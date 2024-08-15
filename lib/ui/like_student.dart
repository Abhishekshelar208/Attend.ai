import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../utils/utils.dart';

class StudentLikePage extends StatefulWidget {
  const StudentLikePage({Key? key}) : super(key: key);

  @override
  State<StudentLikePage> createState() => _StudentLikePageState();
}

class _StudentLikePageState extends State<StudentLikePage> with SingleTickerProviderStateMixin {
  final databaseRef = FirebaseDatabase.instance.ref('Attendance');
  bool _isLoading = true;
  late TabController _tabController;
  String _selectedDivision = 'A'; // Default division

  @override
  void initState() {
    super.initState();
    loadData();
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
          Map attendance = snapshot.value as Map;
          attendance['key'] = snapshot.key;

          DateTime date;
          String lectureName;
          String divisionName;
          String latitude;
          String longitude;

          try {
            date = DateTime.parse(attendance['Date']);
          } catch (e) {
            date = DateTime.now();
          }
          lectureName = attendance['Lecture Name'] ?? 'Unknown Lecture';
          divisionName = attendance['Division Name'] ?? 'Unknown Division';
          latitude = attendance['Latitude']?.toString() ?? 'Unknown Latitude';
          longitude = attendance['Longitude']?.toString() ?? 'Unknown Longitude';

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
                  subtitle: Text('${lectureName} | Division: $division'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            date: DateFormat('dd-MM-yyyy').format(date),
                            lectureName: lectureName,
                            latitude: latitude,
                            longitude: longitude,
                            division: division,
                            divisionName: divisionName,// Pass division to DetailsPage
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF39d2c0),
                    ),
                    child: Text(
                      "View",
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
        },
      ),
    );
  }
}





class DetailsPage extends StatefulWidget {
  final String date;
  final String lectureName;
  final String divisionName;
  final String latitude;
  final String longitude;
  final String division; // Added division parameter

  const DetailsPage({
    Key? key,
    required this.date,
    required this.lectureName,
    required this.divisionName,
    required this.latitude,
    required this.longitude,
    required this.division, // Added division parameter
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final databaseRef = FirebaseDatabase.instance.ref('SubmitedDetails');
  List<int> presentRollNumbers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRollNumbers();
  }

  void fetchRollNumbers() async {
    String uniqueId = "${widget.date}_${widget.lectureName}_${widget.division}";
    DataSnapshot snapshot = await databaseRef.child(uniqueId).get();
    if (snapshot.exists) {
      var data = snapshot.value;
      setState(() {
        if (data is Map) {
          presentRollNumbers = (data as Map).entries
              .where((entry) => entry.value != null && entry.value['Present'] == true)
              .map((entry) => int.parse(entry.key))
              .toList();
        } else if (data is List) {
          for (var i = 0; i < data.length; i++) {
            if (data[i] != null && data[i]['Present'] == true) {
              presentRollNumbers.add(i);
            }
          }
        }
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void togglePresence(int rollNo) async {
    String uniqueId = "${widget.date}_${widget.lectureName}_${widget.division}";
    DatabaseReference rollRef = databaseRef.child('$uniqueId/$rollNo');
    bool isPresent = presentRollNumbers.contains(rollNo);

    await rollRef.set({
      'RollNo': rollNo.toString(),
      'Present': !isPresent,
    });

    setState(() {
      if (isPresent) {
        presentRollNumbers.remove(rollNo);
      } else {
        presentRollNumbers.add(rollNo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalStudents = 77;
    int presentCount = presentRollNumbers.length;
    int absentCount = totalStudents - presentCount;

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
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Attend.ai",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            'Date: ${widget.date}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Lecture: ${widget.lectureName}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Present: $presentCount',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),
                      ),
                      Text(
                        'Absent: $absentCount',
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                (76 / 7).ceil(),
                                    (rowIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(7, (colIndex) {
                                        int rollNo = (rowIndex * 7) + colIndex + 1;
                                        bool isPresent = presentRollNumbers.contains(rollNo);
                                        return GestureDetector(
                                          onLongPress: () {
                                            //togglePresence(rollNo);
                                            Utils().toastMessageBlue("You Can't Edit");
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: isPresent
                                                    ? Colors.white60
                                                    : Colors.red.shade300,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  rollNo.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
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
}
