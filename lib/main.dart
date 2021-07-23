import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Wheel Chair Controller",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Smart Wheel Chair Controller"),
        ),
        body: Text("Test"),
      ),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
