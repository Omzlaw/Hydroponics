import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hydroponics/services/firebase.dart';

import 'model/summaryCard.dart';

class MonitorScreen extends StatefulWidget {
  static String id = 'm';
  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  bool _loaded = false;
  StreamSubscription<Event> ref;
  Firebase firebase = Firebase();
  int conditionValue = 0;

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

  void setCondition(int value){
    setState(() {
      conditionValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.teal,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.teal.withOpacity(0.2), BlendMode.dstATop),
                  image: AssetImage(
                    "assets/images/bg.jpg",
                  ),
                ),
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 40, bottom: 30, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'CONDITIONS',
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Overall System Condition: ${conditionValue > 4 ? 'Good' : conditionValue < 4 ? 'Bad' : 'Average'}',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            _loaded == false
                ? Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.teal),
                      ),
                    ),
                  )
                : Expanded(
                    child: FirebaseAnimatedList(
                      query: firebase.refData(),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        IconData icon;
                        String state = '';
                        int tempConditionValue = 0;
                        switch (snapshot.key) {
                          case "Temperature":
                            {
                              icon = FontAwesomeIcons.temperatureHigh;
                              snapshot.value > 40
                                  ? state = 'Bad'
                                  : state = 'Good';
                              state == 'Bad'
                                  ? tempConditionValue != 0
                                      ? tempConditionValue -= 1
                                      : tempConditionValue = 0
                                  : tempConditionValue == 7 ? tempConditionValue = 7 : tempConditionValue += 1;
                            }
                            break;
                          case "Humidity":
                            {
                              icon = FontAwesomeIcons.tint;
                              snapshot.value > 40
                                  ? state = 'Bad'
                                  : state = 'Good';
                              state == 'Bad'
                                  ? tempConditionValue != 0
                                      ? tempConditionValue -= 1
                                      : tempConditionValue = 0
                                  : tempConditionValue == 7 ? tempConditionValue = 7 : tempConditionValue += 1;
                            }
                            break;
                          case "PH":
                            {
                              icon = FontAwesomeIcons.thermometerEmpty;
                              snapshot.value > 0
                                  ? state = 'Bad'
                                  : state = 'Good';
                              state == 'Bad'
                                  ? tempConditionValue != 0
                                      ? tempConditionValue -= 1
                                      : tempConditionValue = 0
                                  : tempConditionValue == 7 ? tempConditionValue = 7 : tempConditionValue += 1;
                            }
                            break;
                          case "Voltage":
                            {
                              icon = FontAwesomeIcons.bolt;
                              snapshot.value > 40
                                  ? state = 'Bad'
                                  : state = 'Good';
                              state == 'Bad'
                                  ? tempConditionValue != 0
                                      ? tempConditionValue -= 1
                                      : tempConditionValue = 0
                                  : tempConditionValue == 7 ? tempConditionValue = 7 : tempConditionValue += 1;
                            }
                            break;
                          case "Water Level":
                            {
                              icon = FontAwesomeIcons.swimmingPool;
                              snapshot.value > 40
                                  ? state = 'Bad'
                                  : state = 'Good';
                              state == 'Bad'
                                  ? tempConditionValue != 0
                                      ? tempConditionValue -= 1
                                      : tempConditionValue = 0
                                  : tempConditionValue == 7 ? tempConditionValue = 7 : tempConditionValue += 1;
                            }
                            break;
                          case "Dissolved Oxygen":
                            {
                              icon = FontAwesomeIcons.lungs;
                              snapshot.value > 40
                                  ? state = 'Bad'
                                  : state = 'Good';
                              state == 'Bad'
                                  ? tempConditionValue != 0
                                      ? tempConditionValue -= 1
                                      : tempConditionValue = 0
                                  : tempConditionValue == 7 ? tempConditionValue = 7 : tempConditionValue += 1;
                            }
                            break;
                          case "Light Intensity":
                            {
                              icon = FontAwesomeIcons.lightbulb;
                              snapshot.value > 40
                                  ? state = 'Bad'
                                  : state = 'Good';
                              state == 'Bad'
                                  ? tempConditionValue != 0
                                      ? tempConditionValue -= 1
                                      : tempConditionValue = 0
                                  : tempConditionValue == 7 ? tempConditionValue = 7 : tempConditionValue += 1;
                            }
                            break;
                        }
                        {
                          return SummaryCard("${snapshot.key}",
                              "${snapshot.value}", state, icon, setCondition, tempConditionValue);
                        }
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    ref.cancel();
  }
}
