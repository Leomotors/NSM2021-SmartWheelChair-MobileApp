import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/providers/BTProvider.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/providers/DeviceProvider.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/WheelChairCtrl.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/widgets/DrawerMenu.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DeviceProvider>(
          create: (BuildContext context) {
            return DeviceProvider();
          },
        ),
        Provider<BTProvider>(
          create: (BuildContext context) {
            return BTProvider();
          },
        )
      ],
      child: MaterialApp(
        title: "Smart Wheel Chair Controller",
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          fontFamily: "Anakotmai",
        ),
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
        title: Text(
          "ตัวควบคุมรถเข็นไฟฟ้า",
          style: TextStyle(fontSize: 18),
        ),
      ),
      drawer: DrawerMenu(),
      body: WheelChairCtrlPageBody(),
    );
  }
}
