import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:krishna/utils/utils.dart';

class CreateTeacherID extends StatefulWidget {
  CreateTeacherID({Key? key}) : super(key: key);

  @override
  State<CreateTeacherID> createState() => _CreateTeacherIDState();
}

class _CreateTeacherIDState extends State<CreateTeacherID> {
  final databaseRef = FirebaseDatabase.instance.ref('Teacher_ID_&_Password');
  String? name;
  String? selectedID;
  String? selectedPassword;

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController teacherIDController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
              "Create ID",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 580,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 60,
                      child: Image.network("https://i.pinimg.com/736x/42/12/19/42121987e913a73ee9e656ce4060a77f.jpg"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Teacher ID",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Enter Full Name...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: teacherIDController,
                        decoration: InputDecoration(
                          hintText: "Create Teacher ID...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Set Password...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                          'id': DateTime.now().millisecondsSinceEpoch.toString(),
                          'Name': name.text.toString(),
                          'TeacherID': teacherIDController.text.toString(),
                          'Password': passwordController.text.toString(),
                        }).then((value){
                          Utils().toastMessage("ID Created Successfully.");
                          Navigator.pop(context);
                        }).onError((error, stackTrace){
                          Utils().toastMessage(error.toString());
                        });


                        //String teacherID = teacherIDController.text.trim();
                        //String password = passwordController.text.trim();
                        //if (teacherID.isNotEmpty && password.isNotEmpty) {
                        //  _createTeacherID(teacherID, password, context);
                        //} else {
                        //  Utils().toastMessage("Please enter both Teacher ID and Password.");
                        //}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Note:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Required Internet Connection.",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 35,
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
