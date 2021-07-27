import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/DiscoveryPage.dart';

class WaitForBluetoothPage extends StatefulWidget {
  const WaitForBluetoothPage({Key? key}) : super(key: key);

  @override
  _WaitForBluetoothPageState createState() => _WaitForBluetoothPageState();
}

class _WaitForBluetoothPageState extends State<WaitForBluetoothPage> {
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
          return DiscoveryPage();
        } else {
          return DiscoveryPage();
        }
      },
    );
  }
}
