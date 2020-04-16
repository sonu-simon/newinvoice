import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newinvoice/constants/strings.dart';
import 'package:newinvoice/modal/order.dart';
import 'package:newinvoice/services/database.dart';
import 'package:newinvoice/constants/avtrColorRadio.dart';
import 'package:provider/provider.dart';

import 'listorders.dart';

class SortByAvatarColor extends StatefulWidget {
  @override
  _SortByAvatarColorState createState() => _SortByAvatarColorState();
}

class _SortByAvatarColorState extends State<SortByAvatarColor> {
  int _radioOne = 0;
  String _radioSelectedColor;

  void _handleRadioChangeOne(int value) {
    setState(() {
      switch (value) {
        case 0:
          _radioOne = 0;
          _radioSelectedColor = colorOne;
          break;

        case 1:
          _radioOne = 1;
          _radioSelectedColor = colorTwo;
          break;

        case 2:
          _radioOne = 2;
          _radioSelectedColor = colorThree;
          break;

        case 3:
          _radioOne = 3;
          _radioSelectedColor = colorFour;
          break;

        default:
          if(value > 3)
            _handleRadioChangeOne(3);
          else if(value < 0)
            _handleRadioChangeOne(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _radioSelectedColor ??= colorOne;
    final orderssnap = Provider.of<List<Order>>(context) ?? [];
    final selectedColorOrders = [];
    for (Order selectedColorOrder in orderssnap) {
      if (selectedColorOrder.avatarColor == _radioSelectedColor) {
        selectedColorOrders.add(selectedColorOrder);
      }
    }

    return StreamProvider<List<Order>>.value(
        value: DatabaseService().orderssnap,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Sort List'),
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                height: MediaQuery.of(context).size.height * 0.10,
                child: AvatarColorRadio(
                  radioGroupVal: _radioOne,
                  radioHandleChange: _handleRadioChangeOne,
                ),
              ),
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails endDetails) {
                  if (endDetails.primaryVelocity < -200) {
                    print('swipe left');
                    _handleRadioChangeOne(++_radioOne);
                  } else if (endDetails.primaryVelocity > 200) {
                    print('swipe right');
                    _handleRadioChangeOne(--_radioOne);
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.72,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScreenWithData(
                                        orderIndex: index,
                                      )));
                        },
                        title: Text(selectedColorOrders[index].name),
                        subtitle: Text((DateFormat.yMMMd().format(
                                selectedColorOrders[index].dateTimeData))
                            .toString()),
                        leading: CircleAvatar(
                            backgroundColor: Color(int.parse(
                                selectedColorOrders[index].avatarColor))),
                      );
                    },
                    itemCount: selectedColorOrders.length,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
