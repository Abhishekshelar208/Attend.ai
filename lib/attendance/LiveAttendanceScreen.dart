import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LiveAttendanceScreen extends StatelessWidget {
  final String sessionId;

  LiveAttendanceScreen({required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Attendance")),
      body: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref().child("attendance_sessions/$sessionId/students").onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          Map<dynamic, dynamic>? students = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

          return ListView(
            children: students != null
                ? students.entries.map((e) => ListTile(title: Text(e.value['entry']))).toList()
                : [Center(child: Text("No attendance submitted yet."))],
          );
        },
      ),
    );
  }
}
