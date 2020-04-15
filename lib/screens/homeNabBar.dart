import 'package:flutter/material.dart';
import 'package:newinvoice/screens/listorders.dart';
import 'package:newinvoice/screens/sort_color.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List tabs = [ListOrders(), SortByAvatarColor()];
  int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('List'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sort),
              title: Text('Sort'),
            ),
          ]),
    );
  }
}
