import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newinvoice/modal/order.dart';

class DatabaseService {
  final String orderID;
  DatabaseService({this.orderID});

  //creation and using of a new database collection
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');

  Future updateOrder(String orderID, String name, String dateTimeData,
      String avatarColor, String orderQty) async {
    return await orderCollection.document(orderID).setData({
      'orderID': orderID,
      'name': name,
      'dateTimeData': dateTimeData,
      'avatarColor': avatarColor,
      'orderQty': orderQty,
    });
  }

  List<Order> _orderListfromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Order(doc.data['orderID'],doc.data['name'],doc.data['dateTimeData'], doc.data['avatarColor'], doc.data['orderQty']);
    }).toList();
  }

  Stream<List<Order>> get orderssnap {
    return orderCollection.snapshots().map(_orderListfromSnapshot);
  }
}
