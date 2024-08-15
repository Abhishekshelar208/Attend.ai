import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:krishna/ui/rules.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

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
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      String month = months[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MonthlyAttendancePage(month: month),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              month,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RulesPage()));
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.adb, color: Colors.white, size: 32),
      ),
    );
  }
}




class MonthlyAttendancePage extends StatefulWidget {
  final String month;

  const MonthlyAttendancePage({Key? key, required this.month}) : super(key: key);

  @override
  State<MonthlyAttendancePage> createState() => _MonthlyAttendancePageState();
}

class _MonthlyAttendancePageState extends State<MonthlyAttendancePage> {
  final databaseRef = FirebaseDatabase.instance.ref('SubmitedDetails');
  Map<String, int> lectureAttendance = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMonthlyAttendance();
  }

  Future<void> fetchMonthlyAttendance() async {
    DataSnapshot snapshot = await databaseRef.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

      Map<String, int> tempAttendance = {};

      data.forEach((key, value) {
        if (value is Map) {
          String date = key.split('_')[0];
          String lectureName = key.split('_')[1];

          // Parse the date to extract month and year
          DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);
          String monthYear = DateFormat('MM-yyyy').format(parsedDate);

          if (monthYear == "${widget.month}-2024") { // Adjust year as needed
            int count = 0;
            value.forEach((_, status) {
              if (status['Present'] == true) {
                count++;
              }
            });

            tempAttendance[lectureName] = (tempAttendance[lectureName] ?? 0) + count;
          }
        }
      });

      setState(() {
        lectureAttendance = tempAttendance;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance for ${widget.month}"),
        backgroundColor: Colors.black,
      ),
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
          child: _isLoading
              ? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
              : ListView(
            padding: const EdgeInsets.all(16.0),
            children: lectureAttendance.entries.map((entry) {
              String lectureName = entry.key;
              int count = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '$lectureName: $count',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
