import 'package:flutter/material.dart';
import 'package:newinvoice/modal/order.dart';
import 'package:newinvoice/screens/neworder.dart';
import 'package:newinvoice/screens/updateorder.dart';
import 'package:newinvoice/services/database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../services/database.dart';

class ListOrders extends StatefulWidget {
  @override
  _ListOrdersState createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  bool statechange = true;

  @override
  Widget build(BuildContext context) {
    final orderssnap = Provider.of<List<Order>>(context) ?? [];

    return StreamProvider<List<Order>>.value(
      value: DatabaseService().orderssnap,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Orders'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    statechange = !statechange;
                  });
                },
              ),
            ],
          ),
          body: ListView.builder(
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
                title: Text(orderssnap[index].name),
                subtitle: Text((DateFormat.yMMMd().format(orderssnap[index].dateTimeData)).toString()),
                leading: CircleAvatar(
                    backgroundColor:
                        Color(int.parse(orderssnap[index].avatarColor))),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    DatabaseService(orderID: orderssnap[index].orderID).deleteOrder(orderssnap[index].orderID);
                  },
                ),
              );
            },
            itemCount: orderssnap.length,
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: NewOrder(),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Done'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              })),
    );
  }
}

class ScreenWithData extends StatefulWidget {
  final int orderIndex;
  ScreenWithData({this.orderIndex});


  @override
  _ScreenWithDataState createState() => _ScreenWithDataState();
}

class _ScreenWithDataState extends State<ScreenWithData> {

  @override
  Widget build(BuildContext context) {
    final orderssnap = Provider.of<List<Order>>(context) ?? [];
      int index = widget.orderIndex;

    return StreamProvider<List<Order>>.value(
      value: DatabaseService().orderssnap,
      child: Scaffold(
          body: Center(
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(orderssnap[index].orderID)),
            ),
            ListTile(
                title: Text(orderssnap[index].name),
                subtitle: Text((DateFormat.yMMMd().format(orderssnap[index].dateTimeData)).toString()),
                leading: CircleAvatar(
                  backgroundColor: Color(int.parse(orderssnap[index].avatarColor)),
                ),
                trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: UpdateOrder(
                                existOrder: orderssnap[index],
                              ),
                            );
                          });
                    })),
          ],
        ),
      )),
    );
  }
}
