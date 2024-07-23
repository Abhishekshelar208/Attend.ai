
/*


void _submitCode() {
    if (_codeSubmitted) return; // Prevent multiple submissions
    String enteredCode = controllers.map((controller) => controller.text)
        .join();
    DatabaseReference activationRef = FirebaseDatabase.instance.ref(
        'Activation Codes/CodeArray');
    activationRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      dynamic codeArray = snapshot.value;
      if (codeArray != null && codeArray is List) {
        if (codeArray.contains(enteredCode)) {
          _showResult("Processing");
        } else {
          Utils().toastMessage('Invalid Code');
        }
      } else {
        Utils().toastMessage('Activation codes not found');
      }
    }).catchError((error) {
      print('Error retrieving activation codes: $error');
      Utils().toastMessage('Error occurred. Please try again later.');
    });
  }


 */