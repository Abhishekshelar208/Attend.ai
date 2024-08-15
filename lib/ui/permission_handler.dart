import 'package:permission_handler/permission_handler.dart';

import '../utils/utils.dart';

Future<void> _requestLocationPermission() async {
  final status = await Permission.location.request();
  if (status.isDenied) {
    // Handle the case when the user denies the location permission
    Utils().toastMessage('Location permission is required to use this feature.');
  }
}
