// import 'package:firebase_database/firebase_database.dart';
// import 'package:geolocator/geolocator.dart';
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:geolocator/geolocator.dart';
//
// class FirebaseService {
//   // Updated path to where the teacher's location should be stored
//   final DatabaseReference _teacherLocationRef = FirebaseDatabase.instance.ref('Locations/Teacher');
//
//   Future<Position> getTeacherLocation() async {
//     try {
//       // Fetch the location data from Firebase
//       DatabaseEvent event = await _teacherLocationRef.once();
//       final snapshot = event.snapshot;
//
//       if (snapshot.exists) {
//         // Extract latitude and longitude from the snapshot
//         double latitude = snapshot.child('latitude').value as double;
//         double longitude = snapshot.child('longitude').value as double;
//
//         // Create and return a Position object with the fetched data
//         return Position(
//           latitude: latitude,
//           longitude: longitude,
//           timestamp: DateTime.now(),
//           altitude: 0.0, // Default value
//           altitudeAccuracy: 0.0, // Required parameter
//           accuracy: 0.0, // Default value
//           heading: 0.0, // Default value
//           headingAccuracy: 0.0, // Required parameter
//           speed: 0.0, // Default value
//           speedAccuracy: 0.0, // Default value
//         );
//       } else {
//         throw Exception('Teacher location not found');
//       }
//     } catch (e) {
//       throw Exception('Error checking location or submitting code: $e');
//     }
//   }
// }
