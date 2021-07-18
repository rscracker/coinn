import 'package:flutter/material.dart';
import 'navigation/navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home : Navigation(),
    );
  }
}

