import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SummaryCard extends StatefulWidget {
  final String type;
  final IconData icon;
  final String value;
  final String state;
  final Function setCondition;
  final int tempConditionValue;

  const SummaryCard(this.type, this.value, this.state, this.icon, this.setCondition, this.tempConditionValue);

  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     widget.setCondition(widget.tempConditionValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, right: 35, left: 35),
      padding: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                  },
                  icon: FaIcon(
                    widget.icon,
                    color: Colors.teal,
                  ),
                  iconSize: 40,
                ),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(widget.type,
                        style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(widget.value,
                    style: TextStyle(fontSize: 55, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(widget.state,
                  style: TextStyle(),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
