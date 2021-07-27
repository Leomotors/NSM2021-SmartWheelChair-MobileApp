import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/app_constants.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/PairWheelChair.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/WheelChairCtrl.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/widgets/DrawerMenu.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Wheel Chair Controller",
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: "Anakotmai",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Wheel Chair Controller",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      drawer: DrawerMenu(),
      body: WheelChairCtrl(),
    );
  }
}
