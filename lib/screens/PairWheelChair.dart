import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/DiscoveryPage.dart';

class PairWheelChairPage extends StatefulWidget {
  const PairWheelChairPage({Key? key}) : super(key: key);

  @override
  _PairWheelChairPageState createState() => _PairWheelChairPageState();
}

class _PairWheelChairPageState extends State<PairWheelChairPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterBluetoothSerial.instance.requestEnable(),
      builder: (context, future) {
        if (future.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text("ค้นหาอุปกรณ์บลูทูธ"),
            ),
            body: Container(
              height: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.bluetooth_disabled,
                      size: 100,
                      color: Colors.blue,
                    ),
                    Text(
                      "กรุณาเกิดบลูทูธเพื่อใช้งาน",
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (future.connectionState == ConnectionState.done) {
          print("IT SUCCESS?");
          return DiscoveryPage();
        } else {
          print("IT ACTUALLY FAILED");
          return DiscoveryPage();
        }
      },
    );
  }
}
