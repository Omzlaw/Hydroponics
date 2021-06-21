import 'package:flutter/material.dart';

import 'monitor.dart';

class LandingScreen extends StatefulWidget {
  static String id = "l";
  const LandingScreen({key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MonitorScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
              image: AssetImage('assets/images/bg.jpg'),
            ),
          ),
          child: Center(
            child: Container(
              width: 300,
              child: Text(
                "Wana's Hydroponics System",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
    );
  }
}
