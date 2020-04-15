import 'package:flutter/material.dart';
import 'package:newinvoice/constants/strings.dart';
import 'package:newinvoice/services/database.dart';
import 'package:newinvoice/constants/avtrColorRadio.dart';

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
  int orderQty;
  String orderID;
  DateTime orderDateTimeData;

  void _handleRadioChangeOne(int value) {
    setState(() {
      switch (value) {
        case 0:
          avatarColor = colorOne;
          _radioOne = 0;
          break;
        case 1:
          avatarColor = colorTwo;
          _radioOne = 1;
          break;
        case 2:
          avatarColor = colorThree;
          _radioOne = 2;
          break;
        case 3:
          avatarColor = colorFour;
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
                      onChanged: (val) => orderQty = int.parse(val),
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
                      keyboardType: TextInputType.number,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ],
              ),
              AvatarColorRadio(radioGroupVal: _radioOne,radioHandleChange: _handleRadioChangeOne,),
              SizedBox(height: 15.0),
              FlatButton(
                  child: Text('Add to database'),
                  shape: Border.all(),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      //avatarColor.isEmpty ? avatarColor = '0xFFE44236' : avatarColor = avatarColor;

                      orderID = 'order' + DateTime.now().toString();
                      orderDateTimeData = DateTime.now();
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
