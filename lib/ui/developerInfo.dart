import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfo extends StatefulWidget {
  @override
  _DeveloperInfoState createState() => _DeveloperInfoState();
}

class _DeveloperInfoState extends State<DeveloperInfo> {
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
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
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF4b39ef),
              Color(0xFFee8b60),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text(
                "Developer",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Developer",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101213),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 200,
                            width: 200,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://t4.ftcdn.net/jpg/02/76/69/13/360_F_276691386_nl0MPBlwN5sgVhMHmkdqf5nWCHUSEaWs.jpg',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Abhishek Shelar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101213),
                            ),
                          ),
                          const Text(
                            "COMP / TE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101213),
                            ),
                          ),
                          const SizedBox(height: 50),
                          const Text(
                            "Connect with Us",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF101213),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => _launchUrl('https://www.instagram.com/abhishek.shelar28/'),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('lib/assets/images/insta.png'),
                                ),
                              ),
                              const SizedBox(width: 50),
                              GestureDetector(
                                onTap: () => _launchUrl('https://wa.me/919004512415'), // Replace with your WhatsApp link
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('lib/assets/images/wplogo.png'),
                                ),
                              ),
                              const SizedBox(width: 50),
                              GestureDetector(
                                onTap: () => _launchUrl('https://www.linkedin.com/in/abhishek-shelar-0461b7209/'), // Replace with your LinkedIn link
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('lib/assets/images/linkedinlogo.webp'),
                                ),
                              ),
                            ],
                          ),
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
}
