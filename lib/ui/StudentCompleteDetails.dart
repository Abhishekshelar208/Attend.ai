import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyNewNewApp(),

  ));
}




class MyNewNewApp extends StatefulWidget {
  const MyNewNewApp({super.key});

  @override
  State<MyNewNewApp> createState() => _MyNewNewAppState();
}

class _MyNewNewAppState extends State<MyNewNewApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => uploadStudentData(), // Add parentheses here
          child: Text("Store"),
        ),
      ),
    );
  }
  void uploadStudentData() async {
    final databaseReference = FirebaseDatabase.instance.ref("StudentAttendanceDetails");

    List<Map<String, dynamic>> students = [
      {"RollNo": "1", "StudentID": "2022FHCO096", "StudentName": "Pandhare Mahesh Gangaram Pushpa"},
      {"RollNo": "2", "StudentID": "2022FHCO070", "StudentName": "Patade Pratham Rajesh Rahi"},
      {"RollNo": "3", "StudentID": "2022FHCO123", "StudentName": "Pathak Shubham Ashutosh Rajkumari"},
      {"RollNo": "4", "StudentID": "2022FHCO102", "StudentName": "Patil Aahana Rajat Richa"},
      {"RollNo": "5", "StudentID": "2022FHCO066", "StudentName": "Patil Anurag Dilip Sunita"},
      {"RollNo": "6", "StudentID": "2022FHCO080", "StudentName": "Patil Atharva Prabhakar Pratibha"},
      {"RollNo": "7", "StudentID": "2022FHCO083", "StudentName": "Patil Kunal Ganesh Deepa"},
      {"RollNo": "8", "StudentID": "2022FHCO065", "StudentName": "Patil Nikhil Sanjay Sarika"},
      {"RollNo": "9", "StudentID": "2022FHCO027", "StudentName": "Patil Nitin Sadashiv Vandana"},
      {"RollNo": "10", "StudentID": "2022FHCO084", "StudentName": "Patil Omkar Sunil Sugandhi"},
      {"RollNo": "11", "StudentID": "2022FHCO082", "StudentName": "Patil Sakshi Lahu Jayshri"},
      {"RollNo": "12", "StudentID": "2022FHCO058", "StudentName": "Patil Vaishnavi Ramakant Kavita"},
      {"RollNo": "13", "StudentID": "2022FHCO030", "StudentName": "Pawar Mayur Balasaheb Charushila"},
      {"RollNo": "14", "StudentID": "2022FHCO038", "StudentName": "Pimpale Rutuja Pravin Trupti"},
      {"RollNo": "15", "StudentID": "2022FHCO023", "StudentName": "Prabhu Soham Sandeep Sadichha"},
      {"RollNo": "16", "StudentID": "2022FHCO006", "StudentName": "Prasad Divesh Jwala Gyanti"},
      {"RollNo": "17", "StudentID": "2022FHCO020", "StudentName": "Pujare Akash Dattaram Sakshi"},
      {"RollNo": "18", "StudentID": "2022FHCO126", "StudentName": "Rai Satyam Satendra Mamta"},
      {"RollNo": "19", "StudentID": "2022FHCO129", "StudentName": "Rajput Pratap Mangusingh Dariya"},
      {"RollNo": "20", "StudentID": "2022FHCO046", "StudentName": "Ranbawale Aditya Dilip Anita"},
      {"RollNo": "21", "StudentID": "2022FHCO135", "StudentName": "Rane Gopesh Satish Tulsi"},
      {"RollNo": "22", "StudentID": "2022FHCO035", "StudentName": "Rawat Aditya Puran Singh Sangeeta"},
      {"RollNo": "23", "StudentID": "2022FHCO073", "StudentName": "Rokade Ayush Nitin Namrata"},
      {"RollNo": "24", "StudentID": "2022FHCO062", "StudentName": "Sahu Rahul Bhimlal Rukmani"},
      {"RollNo": "25", "StudentID": "2022FHCO063", "StudentName": "Salvi Aniket Sudam Chhaya"},
      {"RollNo": "26", "StudentID": "2022FHCO119", "StudentName": "Sambherao Pranay Shantaram Gulab"},
      {"RollNo": "27", "StudentID": "2022FHCO013", "StudentName": "Sangam Harshika Ajay Jyoti"},
      {"RollNo": "28", "StudentID": "2022FHCO019", "StudentName": "Sarawade Sahil Umesh Swapna"},
      {"RollNo": "29", "StudentID": "2022FHCO077", "StudentName": "Saw Sanjana Sukhamoy Rumpa"},
      {"RollNo": "30", "StudentID": "2022FHCO052", "StudentName": "Sawant Omkar Ravi Archana"},
      {"RollNo": "31", "StudentID": "2022FHCO095", "StudentName": "Sawant Shravani Mahadev Shobha"},
      {"RollNo": "32", "StudentID": "2022FHCO011", "StudentName": "Shaikh Mohammed Farhaan Mohammed Akhtar Anjum Ara"},
      {"RollNo": "33", "StudentID": "2022FHCO071", "StudentName": "Shedge Vaibhav Vijay Jayashree"},
      {"RollNo": "34", "StudentID": "2022FHCO074", "StudentName": "Shete Sahil Raju Sarita"},
      {"RollNo": "35", "StudentID": "2022FHCO130", "StudentName": "Siddiqui Mohammed Aqdas Shoeb Ahmed Zarina"},
      {"RollNo": "36", "StudentID": "2022FHCO110", "StudentName": "Singh Bhoomi Ajay Kavita"},
      {"RollNo": "37", "StudentID": "2022FHCO127", "StudentName": "Singh Shreya Satyendrapratap Usha"},
      {"RollNo": "38", "StudentID": "2022FHCO122", "StudentName": "Soham Navnath Aher Sangeeta"},
      {"RollNo": "39", "StudentID": "2022FHCO059", "StudentName": "Sonawane Diksha Satish Chanchal"},
      {"RollNo": "40", "StudentID": "2022FHCO075", "StudentName": "Songire Sujal Sachin Kalpana"},
      {"RollNo": "41", "StudentID": "2022FHCO061", "StudentName": "Suryawanshi Prasad Jibhau Sandhya"},
      {"RollNo": "42", "StudentID": "2022FHCO088", "StudentName": "Tamhankar Diksha Chandrakant Chaitali"},
      {"RollNo": "43", "StudentID": "2022FHCO037", "StudentName": "Tayade Rohan Vijay Pramila"},
      {"RollNo": "44", "StudentID": "2022FHCO133", "StudentName": "Telawane Krushal Naresh Asha"},
      {"RollNo": "45", "StudentID": "2022FHCO015", "StudentName": "Thanage Aditya Shivaji Anita"},
      {"RollNo": "46", "StudentID": "2022FHCO014", "StudentName": "Thombare Dhiraj Parikshit Kamini"},
      {"RollNo": "47", "StudentID": "2022FHCO028", "StudentName": "Tiwari Riya Mahanarayan Anjana"},
      {"RollNo": "48", "StudentID": "2022FHCO072", "StudentName": "Vekhande Atharva Bhagwan Bhawana"},
      {"RollNo": "49", "StudentID": "2022FHCO090", "StudentName": "Vispute Sanskruti Purushottam Vaishali"},
      {"RollNo": "50", "StudentID": "2022FHCO114", "StudentName": "Wakshe Sanket Bhausaheb Aruna"},
      {"RollNo": "51", "StudentID": "2022FHCO051", "StudentName": "Walilkar Sneha Lalu Yogita"},
      {"RollNo": "52", "StudentID": "2022FHCO076", "StudentName": "Wani Harsh Anil Vandana"},
      {"RollNo": "53", "StudentID": "2022FHCO128", "StudentName": "Wattamwar Aditya Ramesh Shital"},
      {"RollNo": "54", "StudentID": "2022FHCO047", "StudentName": "Waykole Yash Ulhas Deepali"},
      {"RollNo": "55", "StudentID": "2022FHCO024", "StudentName": "Yadav Jinit Virendra Kumar Bindu"},
      {"RollNo": "56", "StudentID": "2022FHCO031", "StudentName": "Yadav Rupesh Mahendra Kanak"},
      {"RollNo": "57", "StudentID": "2022FHCO134", "StudentName": "Yewale Niraj Shankar Reshma"},
      {"RollNo": "58", "StudentID": "2022FHCO081", "StudentName": "Zore Reshma Laxman Kunda"},
      {"RollNo": "59", "StudentID": "2021FHCO038", "StudentName": "Bavaskar Priyanshi Arun Smita"},
      {"RollNo": "60", "StudentID": "2022DSCO028", "StudentName": "Ade Sandhya Ramesh Aruna"},
      {"RollNo": "61", "StudentID": "2023DSCO019", "StudentName": "Narne Harsha Santosh Shubhangi"},
      {"RollNo": "62", "StudentID": "2023DSCO007", "StudentName": "Om Mahesh Patil Leena"},
      {"RollNo": "63", "StudentID": "2023DSCO008", "StudentName": "Parab Jayesh Vilas Vaishnavi"},
      {"RollNo": "64", "StudentID": "2023DSCO004", "StudentName": "Patil Apurva Arun Aruna"},
      {"RollNo": "65", "StudentID": "2023DSCO013", "StudentName": "Poojary Roshni Ravi Ranjeeta"},
      {"RollNo": "66", "StudentID": "2023DSCO023", "StudentName": "Prajwal Vijay Jadhav Sujata"},
      {"RollNo": "67", "StudentID": "2023DSCO014", "StudentName": "Shelar Abhishek Dadasaheb Kavita"},
      {"RollNo": "68", "StudentID": "2023DSCO005", "StudentName": "Shinde Omkar Santosh Anjali"},
      {"RollNo": "69", "StudentID": "2023DSCO022", "StudentName": "Tamanna Bodhwani Sanjana"},
      {"RollNo": "70", "StudentID": "2023DSCO006", "StudentName": "Thakare Uday Vinod Sangita Sangita"},
      {"RollNo": "71", "StudentID": "2023DSCO003", "StudentName": "Varankar Rohan Govind Kalpana"},
      {"RollNo": "72", "StudentID": "2023DSCO020", "StudentName": "Wanghare Payal Dunda Mangal"},
      {"RollNo": "73", "StudentID": "2021FHCO114", "StudentName": "Sharma Dhruv Ramanuj Bindu"},
      {"RollNo": "74", "StudentID": "2021FHCO091", "StudentName": "Waghmare Atharva Santosh Varsha"},
      {"RollNo": "75", "StudentID": "2021FHCO031", "StudentName": "Sakpal Shravan Sanjay Vaishali"},
    ];

    for (var student in students) {
      databaseReference.child(student['RollNo']).set(student);
    }
  }

}
