import 'package:flutter/material.dart';
import 'package:newinvoice/services/database.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

var focusNode = FocusNode();

class _NewOrderState extends State<NewOrder> {
  final _formKey = GlobalKey<FormState>();
  int _radioOne = 0;
  String avatarColor = '0xFFE44236';
  String orderName;
  String orderQty;
  String orderID;
  String orderDateTimeData;

  void _handleRadioChangeOne(int value) {
    setState(() {
      switch (value) {
        case 0:
          avatarColor = '0xFFE44236';
          _radioOne = 0;
          break;
        case 1:
          avatarColor = '0xFF4BCFFA';
          _radioOne = 1;
          break;
        case 2:
          avatarColor = '0xFF45CE30';
          _radioOne = 2;
          break;
        case 3:
          avatarColor = '0xFFF0DF87';
          _radioOne = 3;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: <Widget>[
      Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      focusNode: focusNode,
                      onChanged: (val) => orderName = val,
                      decoration: new InputDecoration(
                        labelText: "Name",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      onChanged: (val) => orderQty = val,
                      decoration: new InputDecoration(
                        labelText: "Quantity",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Qty cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ],
              ),
              Column(children: <Widget>[
                Text('Select an avatar color:'),
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
                          groupValue: _radioOne,
                          activeColor: Colors.red[700],
                          onChanged: _handleRadioChangeOne,
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
                          groupValue: _radioOne,
                          activeColor: Colors.blue[700],
                          onChanged: _handleRadioChangeOne,
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
                          groupValue: _radioOne,
                          activeColor: Colors.green[700],
                          onChanged: _handleRadioChangeOne,
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
                          groupValue: _radioOne,
                          activeColor: Colors.yellow[700],
                          onChanged: _handleRadioChangeOne,
                        ),
                      ),
                    ),
                  ],
                )
              ]),
              SizedBox(height: 15.0),
              FlatButton(
                  child: Text('Add to database'),
                  shape: Border.all(),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      //avatarColor.isEmpty ? avatarColor = '0xFFE44236' : avatarColor = avatarColor;

                      orderID = 'order' + DateTime.now().toString();
                      orderDateTimeData = DateTime.now().toString();
                      DatabaseService(orderID: orderID).updateOrder(orderID,
                          orderName, orderDateTimeData, avatarColor, orderQty);
                      FocusScope.of(context).requestFocus(focusNode);
                      _radioOne = 0;
                      _formKey.currentState.reset();
                      //Navigator.pop(context);
                    }
                  })
            ],
          )),
    ]);
  }
}
