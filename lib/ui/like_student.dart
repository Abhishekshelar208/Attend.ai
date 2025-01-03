// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:krishna/ui/StudentViewPage.dart';
// import 'package:krishna/ui/viewPage.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../utils/utils.dart';
//
// class StudentLikePage extends StatefulWidget {
//   const StudentLikePage({Key? key}) : super(key: key);
//
//   @override
//   State<StudentLikePage> createState() => _StudentLikePageState();
// }
//
// class _StudentLikePageState extends State<StudentLikePage> with SingleTickerProviderStateMixin {
//   final databaseRef = FirebaseDatabase.instance.ref('Attendance');
//   bool _isLoading = true;
//   late TabController _tabController;
//   String _selectedDivision = 'A'; // Default division
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       setState(() {
//         _selectedDivision = _tabController.index == 0 ? 'A' : 'B';
//       });
//     });
//   }
//
//   void loadData() {
//     Future.delayed(Duration(seconds: 2), () {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [
//               Color(0xFF4b39ef),
//               Color(0xFFee8b60),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               const SizedBox(height: 40),
//               Text(
//                 "Attend.ai",
//                 style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white60,
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   child: Column(
//                     children: [
//                       TabBar(
//                         controller: _tabController,
//                         tabs: [
//                           Tab(text: 'Division A'),
//                           Tab(text: 'Division B'),
//                         ],
//                         indicatorColor: Colors.black,
//                       ),
//                       Expanded(
//                         child: TabBarView(
//                           controller: _tabController,
//                           children: [
//                             _buildAttendanceList('A'),
//                             _buildAttendanceList('B'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAttendanceList(String division) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16.0),
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: _isLoading
//           ? Center(
//         child: CircularProgressIndicator(
//           color: Colors.black,
//         ),
//       )
//           : FirebaseAnimatedList(
//         query: databaseRef.orderByChild('Division').equalTo(division),
//         itemBuilder: (context, snapshot, animation, index) {
//           Map attendance = snapshot.value as Map;
//           attendance['key'] = snapshot.key;
//
//           DateTime date;
//           String lectureName;
//           String divisionName;
//           String latitude;
//           String longitude;
//
//           try {
//             date = DateTime.parse(attendance['Date']);
//           } catch (e) {
//             date = DateTime.now();
//           }
//           lectureName = attendance['Lecture Name'] ?? 'Unknown Lecture';
//           divisionName = attendance['Division Name'] ?? 'Unknown Division';
//           latitude = attendance['Latitude']?.toString() ?? 'Unknown Latitude';
//           longitude = attendance['Longitude']?.toString() ?? 'Unknown Longitude';
//
//           return Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Container(
//                 color: Colors.white,
//                 child: ListTile(
//                   leading: Text(
//                     '${index + 1}',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                     ),
//                   ),
//                   title: Text(
//                     DateFormat('dd-MM-yyyy').format(date),
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                     ),
//                   ),
//                   subtitle: Text('${lectureName} | Division: $division'),
//                   trailing: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => StudentViewPage(
//                             // date: DateFormat('dd-MM-yyyy').format(date),
//                             // lectureName: lectureName,
//                             // latitude: latitude,
//                             // longitude: longitude,
//                             // division: division,
//                             // divisionName: divisionName,// Pass division to DetailsPage
//                           ),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF39d2c0),
//                     ),
//                     child: Text(
//                       "View",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
//
//
//
// class DetailsPage extends StatefulWidget {
//   final String date;
//   final String lectureName;
//   final String divisionName;
//   final String latitude;
//   final String longitude;
//   final String division; // Added division parameter
//
//   const DetailsPage({
//     Key? key,
//     required this.date,
//     required this.lectureName,
//     required this.divisionName,
//     required this.latitude,
//     required this.longitude,
//     required this.division, // Added division parameter
//   }) : super(key: key);
//
//   @override
//   _DetailsPageState createState() => _DetailsPageState();
// }
//
// class _DetailsPageState extends State<DetailsPage> {
//
//   Future<void> _launchUrl(String urlString) async {
//     final Uri url = Uri.parse(urlString);
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       throw 'Could not launch $urlString';
//     }
//   }
//   final databaseRef = FirebaseDatabase.instance.ref('SubmitedDetails');
//   List<int> presentRollNumbers = [];
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchRollNumbers();
//   }
//
//   void fetchRollNumbers() async {
//     String uniqueId = "${widget.date}_${widget.lectureName}_${widget.division}";
//     DataSnapshot snapshot = await databaseRef.child(uniqueId).get();
//     if (snapshot.exists) {
//       var data = snapshot.value;
//       setState(() {
//         if (data is Map) {
//           presentRollNumbers = (data as Map).entries
//               .where((entry) => entry.value != null && entry.value['Present'] == true)
//               .map((entry) => int.parse(entry.key))
//               .toList();
//         } else if (data is List) {
//           for (var i = 0; i < data.length; i++) {
//             if (data[i] != null && data[i]['Present'] == true) {
//               presentRollNumbers.add(i);
//             }
//           }
//         }
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void togglePresence(int rollNo) async {
//     String uniqueId = "${widget.date}_${widget.lectureName}_${widget.division}";
//     DatabaseReference rollRef = databaseRef.child('$uniqueId/$rollNo');
//     bool isPresent = presentRollNumbers.contains(rollNo);
//
//     await rollRef.set({
//       'RollNo': rollNo.toString(),
//       'Present': !isPresent,
//     });
//
//     setState(() {
//       if (isPresent) {
//         presentRollNumbers.remove(rollNo);
//       } else {
//         presentRollNumbers.add(rollNo);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int totalStudents = 77;
//     int presentCount = presentRollNumbers.length;
//     int absentCount = totalStudents - presentCount;
//
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [
//               Color(0xFF4b39ef),
//               Color(0xFFee8b60),
//             ],
//           ),
//         ),
//         child: _isLoading
//             ? Center(
//           child: CircularProgressIndicator(
//             color: Colors.white,
//           ),
//         )
//             : SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(height: 40),
//               Text(
//                 "Attend.ai",
//                 style: TextStyle(
//                   fontSize: 36,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.all(20.0),
//                   padding: const EdgeInsets.all(20.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white60,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           const SizedBox(width: 10),
//                           Text(
//                             'Date: ${widget.date}',
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 22,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Text(
//                           'Lecture: ${widget.lectureName}',
//                           style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 22,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         'Present: $presentCount',
//                         style: TextStyle(
//                           color: Colors.white60,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                         ),
//                       ),
//                       Text(
//                         'Absent: $absentCount',
//                         style: TextStyle(
//                           color: Colors.red.shade300,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: List.generate(
//                                 (76 / 7).ceil(),
//                                     (rowIndex) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: List.generate(7, (colIndex) {
//                                         int rollNo = (rowIndex * 7) + colIndex + 1;
//                                         bool isPresent = presentRollNumbers.contains(rollNo);
//                                         return GestureDetector(
//                                           onLongPress: () {
//                                             //togglePresence(rollNo);
//                                             Utils().toastMessageBlue("You Can't Edit");
//                                           },
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Container(
//                                               height: 45,
//                                               width: 45,
//                                               decoration: BoxDecoration(
//                                                 color: isPresent
//                                                     ? Colors.white60
//                                                     : Colors.red.shade300,
//                                                 borderRadius: BorderRadius.circular(20),
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                   rollNo.toString(),
//                                                   style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 18,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () => _launchUrl('https://docs.google.com/spreadsheets/d/1pGwGs36Ip7_p66oQQ9vMM4agkjgZNvzhHSi04HmwXZM/edit?usp=sharing'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blueAccent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           "View Sheet",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:krishna/ui/StudentViewPage.dart';
import 'package:krishna/ui/rules.dart';
import 'package:krishna/ui/viewPage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/utils.dart';
import 'choice_SelectionforView.dart';

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
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
  }
  final databaseRef = FirebaseDatabase.instance.ref('SubmitedDetails');
  List<int> presentRollNumbers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRollNumbers();
  }

  // void fetchRollNumbers() async {
  //   String uniqueId = "${widget.date}_${widget.lectureName}_${widget.division}";
  //   DataSnapshot snapshot = await databaseRef.child(uniqueId).get();
  //   if (snapshot.exists) {
  //     var data = snapshot.value;
  //     setState(() {
  //       if (data is Map) {
  //         presentRollNumbers = (data as Map).entries
  //             .where((entry) => entry.value != null && entry.value['Present'] == true)
  //             .map((entry) => int.parse(entry.key))
  //             .toList();
  //       } else if (data is List) {
  //         for (var i = 0; i < data.length; i++) {
  //           if (data[i] != null && data[i]['Present'] == true) {
  //             presentRollNumbers.add(i);
  //           }
  //         }
  //       }
  //       _isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  void fetchRollNumbers() async {
    String uniqueId = "${widget.date}_${widget.lectureName}_${widget.division}";
    DataSnapshot snapshot = await databaseRef.child(uniqueId).get();

    if (snapshot.exists) {
      var data = snapshot.value;

      setState(() {
        if (data is Map) {
          presentRollNumbers = (data as Map).entries
              .where((entry) => entry.value != null && entry.value['Present'] == true)
              .map((entry) => int.parse(entry.value['Roll No'])) // Fetching Roll No from the student data
              .toList();
        }
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }


  // Future<void> triggerAppsScript() async {
  //   final String webAppUrl = 'https://script.google.com/macros/s/AKfycbzdxYReyEKEInSnOYzVWIDEQbYtx3OljbTd1kgtCOcW09OcgFj5wpUabfBzLI2_PbqR/exec';
  //   try {
  //     final response = await http.get(Uri.parse(webAppUrl));
  //     if (response.statusCode == 200) {
  //       print('Data processed successfully: ${response.body}');
  //     } else {
  //       print('Failed to process data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }


  // void togglePresence(int rollNo) async {
  //   String uniqueId = "${widget.date}_${widget.lectureName}_${widget.division}";
  //   DatabaseReference rollRef = databaseRef.child('$uniqueId/$rollNo');
  //   bool isPresent = presentRollNumbers.contains(rollNo);
  //
  //   await rollRef.set({
  //     'RollNo': rollNo.toString(),
  //     'Present': !isPresent,
  //   });
  //
  //   setState(() {
  //     if (isPresent) {
  //       presentRollNumbers.remove(rollNo);
  //     } else {
  //       presentRollNumbers.add(rollNo);
  //     }
  //   });
  // }

  void togglePresence(int rollNo) async {
    String uniqueId = "${widget.date}_${widget.lectureName}_${widget.division}";

    // Fetch StudentID from RollNo
    String studentID = await getStudentIDFromRollNo(rollNo);

    // Reference to the location in Firebase Database
    DatabaseReference rollRef = databaseRef.child('$uniqueId/$studentID');
    bool isPresent = presentRollNumbers.contains(rollNo);

    // Update presence status in the database
    await rollRef.set({
      'StudentID': studentID,
      'Roll No': rollNo.toString(),
      'Present': !isPresent,
    });

    // Update the local list of present roll numbers
    setState(() {
      if (isPresent) {
        presentRollNumbers.remove(rollNo);
      } else {
        presentRollNumbers.add(rollNo);
      }
    });
  }

// Method to fetch StudentID from RollNo
  Future<String> getStudentIDFromRollNo(int rollNo) async {
    // Replace the following with your actual implementation
    // For example, querying your database to get StudentID for the given RollNo

    // Example: Fetching from a local map (Replace this with actual database call)
    Map<int, String> rollNoToStudentIDMap = {
      1: '2022FHCO096',
      2: '2022FHCO070',
      3: '2022FHCO123',
      4: '2022FHCO102',
      5: '2022FHCO066',
      6: '2022FHCO080',
      7: '2022FHCO083',
      8: '2022FHCO065',
      9: '2022FHCO027',
      10: '2022FHCO084',
      11: '2022FHCO082',
      12: '2022FHCO058',
      13: '2022FHCO030',
      14: '2022FHCO038',
      15: '2022FHCO023',
      16: '2022FHCO006',
      17: '2022FHCO020',
      18: '2022FHCO126',
      19: '2022FHCO129',
      20: '2022FHCO046',
      21: '2022FHCO135',
      22: '2022FHCO035',
      23: '2022FHCO073',
      24: '2022FHCO062',
      25: '2022FHCO063',
      26: '2022FHCO119',
      27: '2022FHCO013',
      28: '2022FHCO019',
      29: '2022FHCO077',
      30: '2022FHCO052',
      31: '2022FHCO095',
      32: '2022FHCO011',
      33: '2022FHCO071',
      34: '2022FHCO074',
      35: '2022FHCO130',
      36: '2022FHCO110',
      37: '2022FHCO127',
      38: '2022FHCO122',
      39: '2022FHCO059',
      40: '2022FHCO075',
      41: '2022FHCO061',
      42: '2022FHCO088',
      43: '2022FHCO037',
      44: '2022FHCO133',
      45: '2022FHCO015',
      46: '2022FHCO014',
      47: '2022FHCO028',
      48: '2022FHCO072',
      49: '2022FHCO090',
      50: '2022FHCO114',
      51: '2022FHCO051',
      52: '2022FHCO076',
      53: '2022FHCO128',
      54: '2022FHCO047',
      55: '2022FHCO024',
      56: '2022FHCO031',
      57: '2022FHCO134',
      58: '2022FHCO081',
      59: '2021FHCO038',
      60: '2022DSCO028',
      61: '2023DSCO019',
      62: '2023DSCO007',
      63: '2023DSCO008',
      64: '2023DSCO004',
      65: '2023DSCO013',
      66: '2023DSCO023',
      67: '2023DSCO014',
      68: '2023DSCO005',
      69: '2023DSCO022',
      70: '2023DSCO006',
      71: '2023DSCO003',
      72: '2023DSCO020',
      73: '2021FHCO114',
      74: '2021FHCO091',
      75: '2021FHCO031',
      // Add more roll numbers and corresponding StudentIDs here
    };

    // Simulate a delay for database query
    await Future.delayed(Duration(seconds: 1));

    // Return the StudentID if found, otherwise return an empty string or handle as needed
    return rollNoToStudentIDMap[rollNo] ?? 'unknown_student_id';
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
                          color: Colors.blueAccent.shade200,
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
                                (76 / 6).ceil(),
                                    (rowIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(6, (colIndex) {
                                        int rollNo = (rowIndex * 6) + colIndex + 1;
                                        bool isPresent = presentRollNumbers.contains(rollNo);
                                        return GestureDetector(
                                          onLongPress: () {
                                            //togglePresence(rollNo);
                                            Utils().toastMessage("You Can't Edit");
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: isPresent
                                                    ? Colors.blueAccent.shade200
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ElevatedButton(
                          //   onPressed: (){
                          //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage(),));
                          //   },
                          //   //onPressed: () => _launchUrl('https://script.google.com/macros/s/AKfycbzEjJzGWOwYwhuRFs0KXB3Pvsuj8d9a9LX_PyDbOgalrMVFc4CJJrIM3nXZq-GiYkDk/exec'),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.green,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(12),
                          //     ),
                          //   ),
                          //   child: Text(
                          //     "Update",
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.w600,
                          //       fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 30,
                          // ),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Choice_SelectionView(),));
                            },
                            //onPressed: () => _launchUrl('https://docs.google.com/spreadsheets/d/1pGwGs36Ip7_p66oQQ9vMM4agkjgZNvzhHSi04HmwXZM/edit?usp=sharing'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "View",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ),
                        ],
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
