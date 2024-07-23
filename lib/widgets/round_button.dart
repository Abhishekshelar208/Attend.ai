import 'package:flutter/material.dart';



class RoundButton extends StatelessWidget {
  final String title;
  const RoundButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10),

          ),
          child: Center(
            child: Text(title,style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,

            ),),
          ),
        ),
      ),
    );
  }
}
