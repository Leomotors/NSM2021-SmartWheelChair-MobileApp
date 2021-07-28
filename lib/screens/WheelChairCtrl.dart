import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/providers/DeviceProvider.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/DiscoveryPage.dart';
import 'package:provider/provider.dart';

class WheelChairCtrlPageBody extends StatefulWidget {
  const WheelChairCtrlPageBody({Key? key}) : super(key: key);

  @override
  _WheelChairCtrlPageBodyState createState() => _WheelChairCtrlPageBodyState();
}

class _WheelChairCtrlPageBodyState extends State<WheelChairCtrlPageBody> {
  bool _isBonded = false;
  bool _isConnected = false;

  String statusDescribe() {
    if (!_isBonded)
      return "ยังไม่ได้เลือกอุปกรณ์";
    else if (!_isConnected)
      return "ยังไม่ได้เชื่อมต่อ";
    else
      return "เชื่อมต่อแล้ว";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, DeviceProvider provider, Widget? child) {
        BluetoothDevice? data = provider.getData();
        _isBonded = (data?.bondState == BluetoothBondState.bonded);
        _isConnected = (data?.isConnected ?? false);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Image.asset(normalWheelChair, height: 150),
              ),
            ),
            Text(
              "สถานะรถเข็น: " + statusDescribe(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            data == null
                ? Container()
                : Column(
                    children: [
                      Text("Device name: ${data.name ?? "IS_NULL"}"),
                      Text("Device Address: ${data.address}"),
                      Text("Device Type: ${data.type}"),
                      Text("Bond State: ${data.bondState}"),
                      Text("Connection State: ${data.isConnected}"),
                    ],
                  ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isConnected
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return DiscoveryPage();
                          },
                        ),
                      );
                    },
              icon: _isConnected
                  ? Icon(Icons.link_off)
                  : Icon(_isBonded ? Icons.link_off : Icons.bluetooth),
              label: Text(_isConnected
                  ? "หยุดเชื่อมต่อ"
                  : _isBonded
                      ? "เลิกจับคู่"
                      : "เปิดเมนูจับคู่รถเข็น"),
            ),
            ElevatedButton.icon(
              onPressed: _isConnected ? () {} : null,
              icon: Icon(Icons.power_off),
              label: Text("ปิดระบบรถเข็น"),
            ),
            SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add_alert),
              label: Text(
                "ขอความช่วยเหลือ",
                style: TextStyle(fontSize: 22),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.red[400]),
            ),
          ],
        );
      },
    );
  }
}
