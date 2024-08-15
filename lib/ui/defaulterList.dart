import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaulterList extends StatefulWidget {
  const DefaulterList({Key? key}) : super(key: key);

  @override
  State<DefaulterList> createState() => _DefaulterListState();
}

class _DefaulterListState extends State<DefaulterList> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('SubmitedDetails');
  Map<String, Map<String, int>> defaulterData = {};

  @override
  void initState() {
    super.initState();
    fetchDefaulterData();
  }

  Future<void> fetchDefaulterData() async {
    try {
      // Fetch all data from 'SubmitedDetails'
      DatabaseEvent event = await _database.once();
      final data = event.snapshot.value as Map<Object?, dynamic>?;

      // Process the data
      Map<String, Map<String, int>> tempData = {};

      data?.forEach((key, value) {
        final dateAndLecture = key.toString().split('_');
        final date = dateAndLecture[0];
        final lecture = dateAndLecture[1];
        final rollNumbers = value as Map<Object?, dynamic>;

        rollNumbers.forEach((rollNo, details) {
          bool present = details['Present'] ?? false;

          if (!tempData.containsKey(rollNo)) {
            tempData[rollNo.toString()] = {
              'Software Engineering': 0,
              'Computer Network': 0,
              'Internet Programming': 0,
              'Theoretical Computer Science': 0,
              'Data Warehousing and Mining': 0,
              'TotalLectures': 0
            };
          }

          if (present) {
            tempData[rollNo.toString()]![lecture] = (tempData[rollNo.toString()]![lecture] ?? 0) + 1;
          }

          tempData[rollNo.toString()]!['TotalLectures'] = (tempData[rollNo.toString()]!['TotalLectures'] ?? 0) + 1;
        });
      });

      setState(() {
        defaulterData = tempData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
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
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListView(
                    children: defaulterData.entries.map((entry) {
                      final rollNo = entry.key;
                      final details = entry.value;
                      final lectures = {
                        'Software Engineering': details['Software Engineering'] ?? 0,
                        'Computer Network': details['Computer Network'] ?? 0,
                        'Internet Programming': details['Internet Programming'] ?? 0,
                        'Theoretical Computer Science': details['Theoretical Computer Science'] ?? 0,
                        'Data Warehousing and Mining': details['Data Warehousing and Mining'] ?? 0,
                      };

                      final totalLectures = details['TotalLectures'] ?? 0;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: lectures.entries.map((entry) {
                          final lectureName = entry.key;
                          final presentCount = entry.value;
                          final status = presentCount / totalLectures < 0.75 ? 'Defaulter' : 'No Defaulter';

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              '$lectureName: ${presentCount}/${totalLectures} - $status',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
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
