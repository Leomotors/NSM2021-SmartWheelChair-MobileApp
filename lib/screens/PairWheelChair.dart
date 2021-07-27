import 'package:flutter/material.dart';

class PairWheelChairPage extends StatefulWidget {
  const PairWheelChairPage({Key? key}) : super(key: key);

  @override
  _PairWheelChairPageState createState() => _PairWheelChairPageState();
}

class _PairWheelChairPageState extends State<PairWheelChairPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("จับคู่รถเข็น"),
      ),
      body: Text("Hello World!"),
    );
  }
}
