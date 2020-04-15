import 'package:flutter/material.dart';

class AvatarColorRadio extends StatelessWidget {
  final int radioGroupVal;
  final Function radioHandleChange;
  AvatarColorRadio({this.radioGroupVal, this.radioHandleChange});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Select an avatar color:'),
      SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 10.0,
              backgroundColor: Colors.red[200],
              child: Radio(
                value: 0,
                groupValue: radioGroupVal,
                activeColor: Colors.red[700],
                onChanged: radioHandleChange,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 10.0,
              backgroundColor: Colors.blue[200],
              child: Radio(
                value: 1,
                groupValue: radioGroupVal,
                activeColor: Colors.blue[700],
                onChanged: radioHandleChange,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 10.0,
              backgroundColor: Colors.green[200],
              child: Radio(
                value: 2,
                groupValue: radioGroupVal,
                activeColor: Colors.green[700],
                onChanged: radioHandleChange,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 10.0,
              backgroundColor: Colors.yellow[200],
              child: Radio(
                value: 3,
                groupValue: radioGroupVal,
                activeColor: Colors.yellow[700],
                onChanged: radioHandleChange,
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
