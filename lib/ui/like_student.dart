import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:krishna/utils/utils.dart';

import 'add_attendance.dart';

class StudentLikePage extends StatefulWidget {
  const StudentLikePage({Key? key}) : super(key: key);

  @override
  State<StudentLikePage> createState() => _StudentLikePageState();
}

class _StudentLikePageState extends State<StudentLikePage> {
  final databaseRef = FirebaseDatabase.instance.ref('Attendance');
  bool _isLoading = true;

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
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              date: DateFormat('dd-MM-yyyy').format(date),
                              lectureName: lectureName,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        "Details",
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
    );
  }
}


class DetailsPage extends StatefulWidget {
  final String date;
  final String lectureName;

  const DetailsPage({
    Key? key,
    required this.date,
    required this.lectureName,
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
    String uniqueId = "${widget.date}_${widget.lectureName}";
    DataSnapshot snapshot = await databaseRef.child(uniqueId).get();
    if (snapshot.exists) {
      Map data = snapshot.value as Map;
      setState(() {
        presentRollNumbers = data.entries
            .where((entry) => entry.value['Present'] == true)
            .map((entry) => int.parse(entry.key))
            .toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void togglePresence(int rollNo) async {
    String uniqueId = "${widget.date}_${widget.lectureName}";
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
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
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Date: ${widget.date}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Lecture: ${widget.lectureName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        (76 / 7).ceil(), // Total rows needed, each containing 7 items
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
                                    Utils().toastMessage('You Cannot Edit');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: isPresent ? Colors.green : Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          rollNo.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
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
    );
  }
}
