

import 'package:firebase_database/firebase_database.dart';
import 'package:gsheets/gsheets.dart';

// Your provided Google Sheets setup code
var sheetId = '1Yx6IEuZVdShPpNT4ILgE9bDnVJ-e7r1jiokZYF1pijo';
var credentials = r'''{
  "type": "service_account",
  "project_id": "central-octane-422608-r9",
  "private_key_id": "f045366b022e68be192eba37e2187be9f236b639",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDDYI2jLS1n4uA7\npbNkkRZ9b12IjFr4jGYSPp4hA+zJFCnDHS7Otdhw05kYT1+dpZaken/G4LZ17wDh\nQDoQU3yk/Eysq6t9/Mzo5giRPchW63L2X4bo64bUJo1Vz4OJP6sdO/wHQP6lsGWj\n9of/x3KI0uG8kwKAeKmZL2tu0JYE+wBXHE1av94gHdkCf/dB9RHR8Fl9tlYRPw1k\n5lvSDV8KwmZ65QMTzbknnNZFwWiUWcYnK8XvP9G05uA9KhTDTTS2kMybORphE0ut\n/x6fWdfe2ZUKAGGyT5caC5gUpFO8lUgA1T2ma5uvsVM63RgdoFNHXA5Q9Z/JwqCq\n/fUyCgBFAgMBAAECggEAIExL3dfQE8ZrrzCbUVqyzxWj7rjVKRV8ojN7zJVrhWox\n5TFj1YQ2PaCdRGmKsvL2zkX57ZSkVSanjJUjhCNpDZUvz7Opa/Bop2+vpuMBxWyy\n2ou8L7EP3u5omvDtG7lMvk52QXS7JATfKJXOsbf09S13Z8cduMM5tjsilXUh97yE\nO9lGQmu5Cl/Ceo93rpYyif6hVCsjaEY7RAjLIX7xpY2+HI4obsEkYN4YPWLG9G+8\nFbcmw7Vr8Y98A9NvVSPHFadltZfPfR41d1/trV9VCozhOeJjgzkoX9nTFGdkcdBu\nwrUQsxPI3XxNTYofE9g5rVenFb6tVL1RUh5mVwIEQQKBgQD8Z1KmrNbanH/JIgER\n+cqsRACtnHTri7pkIQwN1p6fD2t7BRMRKu5PJWrafTsWUf7waGLC27ayImp1wpl5\n//2WZ49NgWEZ92JXBxoqBo9RNQAJVaSVe8ovsJ1hgzjpst/UjwWxtDmv0C3/5Y/W\nlb+rNe1VOt0Qaz6D2j1+ZRLMDQKBgQDGKTfzPtpUOsXhgjdLB0hI6UJv7+UJFpBA\nG7qRCQqU9vV6+keYeYqa9+G2U0ycSOhQoXSk3poAvIMvF0mYPqE6jx/aAM7a6jHQ\n7yrHYwjBgNTHI0if/PG68PaskURDlpDoDUu1h8HTRMK6XFtfKakLXmKpdTux7dYO\nvuUIClifGQKBgQDHFgR2XYxXAOw2TLEFab74I+dZCTib9im+AucMH0YcdkAz16vT\ndcZk/UGMNw0dLO3m2J9VzZIMbeMFIcqHFWkDconw+2UI4z1ZIcv8bBItXp25vyjD\nk9HFzgxFNwj0JNgyQ+Gc6mg6Cf3Og1byTknRlQavnG90HPNBcyngAX9THQKBgC3H\nL+m9x2pV+YjTMDrg/834NSTu4pZq5AArZ7pBwHQRaTxzvT54NZD/WuFn9PbV0PVv\nlybPVfx9kEC8vH+zWEPS9KTEMwVXvRJrbhKJymgJfx5SBGERajapnBLZrE+A5RD2\noVradeh8pg+vblxZn3fE4j4LmzLLovvdFcP5v+dhAoGAHn/U+Fy1cb5/T94ItS8h\null9QTKyjN9Y3sv+KwpZ7JZ+1meK7xIyP8ULbvnf2GLAinq4p03+CcO8hvQp9XEz\nGZRAfeT/UzAbYH55f9bdFuTwWb/kBxF8nAY9MSbtuej8arOUJ9tSwrB6qkbVsYqy\nTyc1B0BdW0uXZVVGsKZYKmQ=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheet-for-attendance@central-octane-422608-r9.iam.gserviceaccount.com",
  "client_id": "101063691501301635408",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheet-for-attendance%40central-octane-422608-r9.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

final gsheetinit = GSheets(credentials);

var GsheetController;
Worksheet? gsheetCrudUserDetails;

GsheetIntit() async {
  GsheetController = await gsheetinit.spreadsheet(sheetId);
  gsheetCrudUserDetails = await GsheetController.worksheetByTitle('Software Engineering');
}

// Function to fetch data from Realtime Database and store it in Google Sheets
Future<void> fetchAndStoreData() async {
  try {
    // Initialize the GSheet if not done already
    if (gsheetCrudUserDetails == null) {
      await GsheetIntit();
    }

    // Fetch data from Firebase Realtime Database "SubmitedDetails" node
    final databaseReference = FirebaseDatabase.instance.ref('SubmitedDetails');
    final submitedDetailsSnapshot = await databaseReference.get();

    // Check if data exists
    if (submitedDetailsSnapshot.exists) {
      Map<String, dynamic> data = Map<String, dynamic>.from(submitedDetailsSnapshot.value as Map);

      // Iterate through the data
      data.forEach((key, value) async {
        // 'key' might be a Date_LectureName key, 'value' contains roll number and present status
        Map<String, dynamic> details = Map<String, dynamic>.from(value);

        details.forEach((rollNumber, presentDetails) async {
          if (gsheetCrudUserDetails != null) {
            await gsheetCrudUserDetails!.values.appendRow([key, rollNumber, presentDetails['Present']]);
          }
        });
      });
    } else {
      print('No data found in SubmitedDetails');
    }
  } catch (e) {
    print('Error fetching or storing data: $e');
  }
}







