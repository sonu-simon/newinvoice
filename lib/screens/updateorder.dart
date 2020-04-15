import 'package:flutter/material.dart';
import 'package:newinvoice/constants/strings.dart';
import 'package:newinvoice/modal/order.dart';
import 'package:newinvoice/services/database.dart';
import 'package:newinvoice/constants/avtrColorRadio.dart';

class UpdateOrder extends StatefulWidget {
  final Order existOrder;
  UpdateOrder({this.existOrder});

  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

var focusNode = FocusNode();

class _UpdateOrderState extends State<UpdateOrder> {
  final _formKey = GlobalKey<FormState>();
  int _radioOne;
  String avatarColor;
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
  void initState() {
    switch (widget.existOrder.avatarColor) {
      case colorOne:
        _radioOne = 0;
        avatarColor = colorOne;
        break;
      case colorTwo:
        _radioOne = 1;
        avatarColor = colorTwo;
        break;
      case colorThree:
        _radioOne = 2;
        avatarColor = colorThree;

        break;
      case colorFour:
        _radioOne = 3;
        avatarColor = colorFour;

        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orderID = widget.existOrder.orderID;
    orderDateTimeData = widget.existOrder.dateTimeData;

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
                      initialValue: widget.existOrder.name,
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
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      initialValue: widget.existOrder.orderQty.toString(),
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
                          return "Quantity cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              AvatarColorRadio(
                radioGroupVal: _radioOne,
                radioHandleChange: _handleRadioChangeOne,
              ),
              SizedBox(height: 15.0),
              FlatButton(
                  child: Text('Save to database'),
                  shape: Border.all(),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      orderName ??= widget.existOrder.name;
                      orderQty ??= widget.existOrder.orderQty;
                      DatabaseService(orderID: orderID).updateOrder(orderID,
                          orderName, orderDateTimeData, avatarColor, orderQty);
                      FocusScope.of(context).requestFocus(focusNode);
                      _radioOne = 0;
                      Navigator.of(context).pop();
                    }
                  })
            ],
          )),
    ]);
  }
}
