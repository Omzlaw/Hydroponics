import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hydroponics/services/firebase.dart';

class MonitorScreen extends StatefulWidget {
  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  bool _loaded = false;
  StreamSubscription<Event> ref;
  Firebase firebase = Firebase();

  void checkForData() {
    ref = firebase.refData().onChildAdded.listen((Event event) {
      if (event != null) {
        setState(() {
          _loaded = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    firebase.setRef();
    checkForData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    ref.cancel();
  }
}
