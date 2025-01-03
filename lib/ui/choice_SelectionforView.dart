
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs



void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Choice_SelectionView(),
  ));
}
class Choice_SelectionView extends StatefulWidget {
  @override
  _Choice_SelectionViewState createState() => _Choice_SelectionViewState();
}

class _Choice_SelectionViewState extends State<Choice_SelectionView> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown options for subjects and divisions
  final List<String> _subjects = ['SE', 'CN', 'IP', 'DWM', 'TCS', 'PCE'];
  final List<String> _divisions = ['Division A', 'Division B'];

  // Selected values
  String? _selectedSubject;
  String? _selectedDivision;

  @override
  void initState() {
    super.initState();
    _selectedSubject = _subjects[0]; // Default to the first subject
    _selectedDivision = _divisions[0]; // Default to the first division
  }



  void _updateProfile() {
    // Based on subject and division, generate a unique URL
    String? url = _getUniqueUrl(_selectedSubject, _selectedDivision);

    if (url != null) {
      _launchUrl(url); // Launch the URL if it's valid
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No URL found for this combination')),
      );
    }
  }

  void _updateProfileView() {
    // Based on subject and division, generate a unique URL
    String? url = _getUniqueUrlView(_selectedSubject, _selectedDivision);

    if (url != null) {
      _launchUrl(url); // Launch the URL if it's valid
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No URL found for this combination')),
      );
    }
  }

  String? _getUniqueUrl(String? subject, String? division) {
    // Define unique URLs for each subject + division combination
    Map<String, String> urlMap = {
      'SE_Division A': 'https://script.google.com/macros/s/AKfycbzu0K-MED9dp5VNYe08Jc-G_tS6JZg64fihwJeszyBzq_2Nw3FlfI3vA_JbURVF7Nqz/exec',
      'SE_Division B': 'https://script.google.com/macros/s/AKfycbzPlo8SdrGZihb5UtDPH77cynGNSyVKDsR-5Jdd1GawVQxvG9omya3dLvsDnWh9x4Cpdw/exec',
      'CN_Division A': 'https://script.google.com/macros/s/AKfycbyTCL3gvNbtD9t1BjohJPu0UOznoRQLzy9CqaOC3o-Ezyh67Mgi7unuaSiUoI_S595QKg/exec',
      'CN_Division B': 'https://script.google.com/macros/s/AKfycbwbrtQVUnbGNqHYRPzZfGLzdPHi4eeycGZPjFaKgp5ZpL9q5UkqVnI3Q1oNmcK6TH52/exec',
      'IP_Division A': 'https://script.google.com/macros/s/AKfycbz9x4bGyiUypDEOjwwPrCARU52HmPTz5LEpD2SXQwQD6bz_AIMbRxY08tFkPj3f7cpm/exec',
      'IP_Division B': 'https://script.google.com/macros/s/AKfycbxmT5jrj1lHjQhIP-kRcml_b5vdI0ZH4XT17dsQSDUkcDyP5e-hBZm_ybZtp2-3kDsL/exec',
      'DWM_Division A': 'https://script.google.com/macros/s/AKfycbz94U62V2jrKcWNnTiZntGauz6r85y5SKWML-2_M1y9_iQ2kpWwShGdXuELZzWLsQj2/exec',
      'DWM_Division B': 'https://script.google.com/macros/s/AKfycbxesAk6JmIASy0Kgbl11e6YWjvWFxLHOA_fIZQYfyVzIGVqoXz5j1JtngYwqK6GoSBW/exec',
      'TCS_Division A': 'https://script.google.com/macros/s/AKfycbx6rH7eiF7-1NrDMv2pi4IijYpj9yyZMUI4p85QHwZZWaGeQXL88xwO9z-y7qkC7KiC/exec',
      'TCS_Division B': 'https://script.google.com/macros/s/AKfycbyF5w_et6FGyZmzu6qiqGojKFkmcaKiooOuxnULyVqF16MOLi2iS9EYcujOofHHBP8L/exec',
      'PCE_Division A': 'https://script.google.com/macros/s/AKfycbwqvW19Jf2QLL5DlU5aESIgaDeLh-jij-rFOHp0S7bgxcmdcEGSObha6qnIzRtnEw_LEQ/exec',
      'PCE_Division B': 'https://script.google.com/macros/s/AKfycbxKnHVfZzPsR88jKvC26o-MBqVvKSW26QMltFZjR9CKKhY8KMyNd13a_nLociBaNvw/exec',
    };

    // Combine subject and division to get the corresponding URL
    String key = '${subject}_${division}';
    return urlMap[key];
  }

  String? _getUniqueUrlView(String? subject, String? division) {
    // Define unique URLs for each subject + division combination
    Map<String, String> urlMap = {
      'SE_Division A': 'https://docs.google.com/spreadsheets/d/1-jJsK-Y0psRD50YoKaQ1jxWvPy8xVTiEzF3-81iNZH0/edit?gid=681019978#gid=681019978',
      'SE_Division B': 'https://docs.google.com/spreadsheets/d/16mt6oq7nNqH3TkhsIwJ4q0irF3xvMJk1_nVtXErv9WY/edit?gid=1225017201#gid=1225017201',
      'CN_Division A': 'https://docs.google.com/spreadsheets/d/1D8y7JzheDeGmsUDVawSDHz2jeaMSpMnGVfe6zH7_pWk/edit?gid=1502205952#gid=1502205952',
      'CN_Division B': 'https://docs.google.com/spreadsheets/d/1Gik9crQjCjA0AewY0gNGBWfW0ydjjSUbs9v5828NmmA/edit?gid=971593161#gid=971593161',
      'IP_Division A': 'https://docs.google.com/spreadsheets/d/1hLMfRMeKMgESmtcU9G4WyXQyhzpOt63BK3n3nCpGtGc/edit?gid=1838958075#gid=1838958075',
      'IP_Division B': 'https://docs.google.com/spreadsheets/d/16eagdc0pnkBbaDaZbXUGinZO2YkkRZldNJTAleHoazc/edit?gid=881536600#gid=881536600',
      'DWM_Division A': 'https://docs.google.com/spreadsheets/d/1KKxRF2a8FROU7GClX6eXpAl1dzxk_9M0h1zooKjnImo/edit?gid=1016154455#gid=1016154455',
      'DWM_Division B': 'https://docs.google.com/spreadsheets/d/1WiJGRvcp_3mE8BOc5fy6fAy-9H2-vXJDlTf6R3GUawM/edit?gid=927445618#gid=927445618',
      'TCS_Division A': 'https://docs.google.com/spreadsheets/d/1LqP9lPAr-ghdSG7m-mY5_n7xyM6E6ji6Xyf5LNpKmAs/edit?gid=114537537#gid=114537537',
      'TCS_Division B': 'https://docs.google.com/spreadsheets/d/1q2Ig6O_0h65d4bEkkvB4IrKy1PH0RPHrhNu5Cx8RF3I/edit?gid=616771548#gid=616771548',
      'PCE_Division A': 'https://docs.google.com/spreadsheets/d/1gQX3Lls_0xCO8IpbBo5HlyZ6TJfb1aITyuhZsHHvRGc/edit?gid=2025600673#gid=2025600673',
      'PCE_Division B': 'https://docs.google.com/spreadsheets/d/13kWhhqfpD249lXLysBxFnLAfUIzDW1ZNp2lkx9DKWgQ/edit?gid=1119661283#gid=1119661283',
    };

    // Combine subject and division to get the corresponding URL
    String key = '${subject}_${division}';
    return urlMap[key];
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.08,
            horizontal: screenWidth * 0.03,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.030),
              Text(
                "Attend.ai",
                style: TextStyle(
                  fontSize: screenWidth * 0.1,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.080),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: screenHeight * 0.020),
                          Text(
                            "View",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.080,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              color: Color(0xFF101213),
                            ),
                          ),
                          Text(
                            "Attendance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.080,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                              color: Color(0xFF101213),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          // Dropdown for selecting Subject
                          buildDropdown('Subject', _selectedSubject, _subjects, (String? newValue) {
                            setState(() {
                              _selectedSubject = newValue;
                            });
                          }),
                          // Dropdown for selecting Division
                          buildDropdown('Division', _selectedDivision, _divisions, (String? newValue) {
                            setState(() {
                              _selectedDivision = newValue;
                            });
                          }),
                          SizedBox(height: screenHeight * 0.030),
                          // Update Button
                          // SizedBox(
                          //   width: screenWidth * 0.7,
                          //   height: screenHeight * 0.045,
                          //   child: ElevatedButton(
                          //     onPressed: _updateProfile,
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: Color(0xFF4b39ef),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(12),
                          //       ),
                          //     ),
                          //     child: Text(
                          //       'Update',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.bold,
                          //         fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: screenHeight * 0.020),
                          // Optional Reset Button if needed
                          SizedBox(
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.045,
                            child: ElevatedButton(
                              onPressed: _updateProfileView,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'View',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.010),
                        ],
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

  Widget buildDropdown(String label, String? selectedValue, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFF1F4F8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.all(16),
        ),
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
