import 'package:flutter/material.dart';
import 'package:newinvoice/screens/homeNabBar.dart';
import 'package:newinvoice/services/database.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: DatabaseService().orderssnap,
        child: MaterialApp(
          home: BottomNavBar(),
        ));
  }
}
