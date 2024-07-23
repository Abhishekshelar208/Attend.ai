import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:krishna/utils/utils.dart';

class AddAttendance extends StatefulWidget {
  const AddAttendance({Key? key}) : super(key: key);

  @override
  _AddAttendanceState createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {
  final databaseRef = FirebaseDatabase.instance.ref('Attendance');
  //final submittedRef = FirebaseDatabase.instance.ref('SubmitedDetails');
  String? selectedYear;
  String? selectedBranch;
  DateTime? selectedDate;
  String? selectedLectureName;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
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
              "Attendance",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 650,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Lecture Name:",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedLectureName,
                        decoration: InputDecoration(
                          hintText: "Select Lecture...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        items: [
                          "Software Engineering",
                          "Computer Network",
                          "Internet Programming",
                          "Theoretical Computer Science",
                          "Data Warehousing and Mining"
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Lecture Date:",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: selectedDate != null
                              ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                              : "Select Date...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Year:",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedYear,
                        decoration: InputDecoration(
                          hintText: "Select Year...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Branch:",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedBranch,
                        decoration: InputDecoration(
                          hintText: "Select Branch...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
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
                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedDate != null && selectedLectureName != null) {
                          databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                            'Attendance Id': DateTime.now().millisecondsSinceEpoch.toString(),
                            'Lecture Name': selectedLectureName!,
                            'Date': selectedDate.toString(),
                            'Year': selectedYear.toString(),
                            'Branch': selectedBranch.toString(),
                            'DeActivated': false, // Initialize as not activated
                          }).then((value) {
                            Utils().toastMessage("Attendance Added Successfully.");
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                          });

                          // Removed the following part:
                          // String uniqueId = "${DateFormat('yyyy-MM-dd').format(selectedDate!)}_${selectedLectureName!}";
                          // submittedRef.child(uniqueId).set({
                          //   'Date': selectedDate.toString(),
                          //   'Lecture Name': selectedLectureName!,
                          //   //'AdditionalFields': [], reserved for rollno.
                          //   // Add other fields if needed
                          // }).then((value) {
                          //   Utils().toastMessage("Submitted Successfully.");
                          //   Navigator.pop(context); // Close the screen after submission
                          // }).onError((error, stackTrace) {
                          //   Utils().toastMessage(error.toString());
                          // });

                          Navigator.pop(context); // Close the screen after submission
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Activate",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
