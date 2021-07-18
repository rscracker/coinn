import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/log.dart';
import '../screens/setting.dart';
class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _index = 1;
  var pages = [
    Log(),
    Home(),
    Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Coin"),
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          currentIndex: _index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'log',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'set',
              icon: Icon(Icons.home),
            ),
          ]),
    );
  }
}
