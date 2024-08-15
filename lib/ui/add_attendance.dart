import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:krishna/utils/utils.dart';
// import 'package:geolocator/geolocator.dart';

class AddAttendance extends StatefulWidget {
  const AddAttendance({Key? key}) : super(key: key);

  @override
  _AddAttendanceState createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {
  final databaseRef = FirebaseDatabase.instance.ref('Attendance');
  String? selectedYear;
  String? selectedBranch;
  String? selectedDivision;
  String? selectedType;
  String? selectedBatch;
  DateTime? selectedDate;
  String? selectedLectureName;
  // double? latitude;
  // double? longitude;
  bool isLoading = false;
  String? currentTime; // Add a variable to store the current time

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // Future<void> _getLocation() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     setState(() {
  //       latitude = position.latitude;
  //       longitude = position.longitude;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Utils().toastMessage("Error getting location: $e");
  //   }
  // }
  void _fetchCurrentTime() {
    // Fetch the current time and format it
    final now = DateTime.now();
    currentTime = DateFormat('yyyy-MM-dd hh:mm:ss a').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF4b39ef),
              Color(0xFFee8b60),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Attend.ai",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  height: 630, // Increased height to accommodate new fields
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text(
                          "Attendance",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF101213),
                          ),
                        ),
                        Text(
                          "Make an annoucement before taking attendance",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF57636c),
                          ),
                        ),
                        Text(
                          "so students can ready with their phone",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0xFF57636c),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedLectureName,
                            decoration: InputDecoration(
                              hintText: "Select Lecture...",
                              hintStyle: TextStyle(color: Color(0xFF57636c)),
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: [
                              "SE",
                              "CN",
                              "IP",
                              "TCS",
                              "DWM"
                            ].map((lecture) {
                              return DropdownMenuItem(
                                value: lecture,
                                child: Text(lecture),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedLectureName = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: selectedDate != null
                                  ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                                  : "Select Date...",
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () {
                                  _selectDate(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedYear,
                            decoration: InputDecoration(
                              hintText: "Select Year...",
                              hintStyle: TextStyle(color: Color(0xFF57636c)),
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: ["FE", "SE", "TE", "BE"].map((year) {
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedYear = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedBranch,
                            decoration: InputDecoration(
                              hintText: "Select Branch...",
                              hintStyle: TextStyle(color: Color(0xFF57636c)),
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: ["CO", "IT", "ME", "CE", "AIDS"].map((branch) {
                              return DropdownMenuItem(
                                value: branch,
                                child: Text(branch),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedBranch = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedDivision,
                            decoration: InputDecoration(
                              hintText: "Select Division...",
                              hintStyle: TextStyle(color: Color(0xFF57636c)),
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: ["A", "B"].map((division) {
                              return DropdownMenuItem(
                                value: division,
                                child: Text(division),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedDivision = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedType,
                            decoration: InputDecoration(
                              hintText: "Select Type...",
                              hintStyle: TextStyle(color: Color(0xFF57636c)),
                              filled: true,
                              fillColor: Color(0xFFF1F4F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: ["Lecture", "Practical"].map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedType = value;
                                selectedBatch = null; // Reset batch selection if type changes
                              });
                            },
                          ),
                        ),
                        if (selectedType == "Practical") // Show batch selection only if Practical is selected
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: DropdownButtonFormField<String>(
                              value: selectedBatch,
                              decoration: InputDecoration(
                                hintText: "Select Batch...",
                                hintStyle: TextStyle(color: Color(0xFF57636c)),
                                filled: true,
                                fillColor: Color(0xFFF1F4F8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: ["Batch 1", "Batch 2","Batch 3", "Batch 4"].map((batch) {
                                return DropdownMenuItem(
                                  value: batch,
                                  child: Text(batch),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedBatch = value;
                                });
                              },
                            ),
                          ),
                        const SizedBox(height: 20,),
                        // SizedBox(
                        //   width: 300,
                        //   height: 44,
                        //   child: ElevatedButton(
                        //     onPressed: _getLocation,
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.greenAccent.shade200,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //     ),
                        //     child: isLoading
                        //         ? CircularProgressIndicator(
                        //       color: Colors.white,
                        //     )
                        //         : Text(
                        //       'Get Location',
                        //       style: TextStyle(
                        //         color: Colors.black54,
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.bold,
                        //         fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // if (latitude != null && longitude != null)
                        //   Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: Column(
                        //       children: [
                        //         Text(
                        //           "Lat: $latitude, Long: $longitude",
                        //           style: TextStyle(
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w600,
                        //             fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: 350,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (selectedLectureName != null &&
                                  selectedDate != null &&
                                  selectedYear != null &&
                                  selectedBranch != null &&
                                  selectedDivision != null &&
                                  selectedType != null &&
                                  (selectedType != "Practical" || selectedBatch != null)
                                  // && latitude != null && longitude != null
                              )
                              {
                                try {
                                  _fetchCurrentTime();
                                  await databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                                    'Attendance Id': DateTime.now().millisecondsSinceEpoch.toString(),
                                    'Lecture Name': selectedLectureName,
                                    'Date': selectedDate.toString(),
                                    'Time': currentTime.toString(),
                                    'Year': selectedYear,
                                    'Branch': selectedBranch,
                                    'Division': selectedDivision,
                                    'Type': selectedType,
                                    'Batch': selectedBatch,
                                    // 'Latitude': latitude,
                                    // 'Longitude': longitude,
                                  });
                                  Utils().toastMessage('Attendance added successfully');
                                } catch (e) {
                                  Utils().toastMessage('Failed to add attendance: $e');
                                }
                              } else {
                                Utils().toastMessage('Please fill all the details');
                              }
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4b39ef),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Activate',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
