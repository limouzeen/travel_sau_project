import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_sau_project/views/login_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    super.initState();
    // Adding a delay of 3 seconds before navigating to the next screen
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                LoginUI()), // Replace NextScreen() with your next screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                'assets/images/logo.png',
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                'บันทึกการเดินทาง',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.045),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              CircularProgressIndicator(
                color: Colors.grey,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                'Created by : 6552410012',
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: MediaQuery.of(context).size.height * 0.02),
              ),
              Text(
                'Amarat Kositwongsakul',
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: MediaQuery.of(context).size.height * 0.02),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
