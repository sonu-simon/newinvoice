import 'package:flutter/material.dart';
import 'package:newinvoice/modal/order.dart';
import 'package:newinvoice/screens/neworder.dart';
import 'package:newinvoice/screens/updateorder.dart';
import 'package:newinvoice/services/database.dart';
import 'package:provider/provider.dart';

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
                                order: orderssnap[index],
                              )));
                },
                title: Text(orderssnap[index].name),
                subtitle: Text(orderssnap[index].dateTimeData),
                leading: CircleAvatar(
                  backgroundColor: Color(int.parse(orderssnap[index].avatarColor))
                ),
                trailing: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    orderssnap.removeAt(index);
                    
                    setState(() {
                      statechange = !statechange;
                    });
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

class ScreenWithData extends StatelessWidget {
  final Order order;
  ScreenWithData({this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(order.orderID)),
          ),
          ListTile(
            title: Text(order.name),
            subtitle: Text(order.dateTimeData),
            leading: CircleAvatar(
              backgroundColor: Color(int.parse(order.avatarColor)),
            ),
            trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
               showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: UpdateOrder(existOrder: order,),
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
              })
            
          ),
        ],
      ),
    ));
  }
}
