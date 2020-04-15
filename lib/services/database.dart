import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newinvoice/modal/order.dart';

class DatabaseService {
  final String orderID;
  DatabaseService({this.orderID});

  //creation and using of a new database collection
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');

  Future updateOrder(String orderID, String name, DateTime dateTimeData,
      String avatarColor, int orderQty) async {
    print(dateTimeData.toString());
    String dateTimeString = (dateTimeData).toString();

    return await orderCollection.document(orderID).setData({
      'orderID': orderID,
      'name': name,
      'dateTimeData': dateTimeString,
      'avatarColor': avatarColor,
      'orderQty': orderQty,
    });
  }

  Future deleteOrder(String orderID) async {
    return await orderCollection.document(orderID).delete();
  }

  List<Order> _orderListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      DateTime dateTimeData = DateTime.parse(doc.data['dateTimeData']);
      return Order(doc.data['orderID'], doc.data['name'], dateTimeData,
          doc.data['avatarColor'], doc.data['orderQty']);
    }).toList();
  }

  Stream<List<Order>> get orderssnap {
    return orderCollection.snapshots().map(_orderListfromSnapshot);
  }
}
