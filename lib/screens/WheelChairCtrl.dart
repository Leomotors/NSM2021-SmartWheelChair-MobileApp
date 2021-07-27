import 'package:flutter/material.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/WaitForBluetoothPage.dart';

class WheelChairCtrlPageBody extends StatefulWidget {
  const WheelChairCtrlPageBody({Key? key}) : super(key: key);

  @override
  _WheelChairCtrlPageBodyState createState() => _WheelChairCtrlPageBodyState();
}

class _WheelChairCtrlPageBodyState extends State<WheelChairCtrlPageBody> {
  String _statusDescribe = "ไม่ได้เชื่อมต่อ";
  bool _paired = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Image.asset(normalWheelChair, height: 150),
          ),
        ),
        Text(
          "สถานะรถเข็น: " + _statusDescribe,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return WaitForBluetoothPage();
                },
              ),
            );
          },
          icon: Icon(_paired ? Icons.link_off : Icons.bluetooth),
          label: Text(_paired ? "หยุดเชื่อมต่อ" : "เปิดเมนูจับคู่รถเข็น"),
        ),
        ElevatedButton.icon(
          onPressed: _paired ? () {} : null,
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
  }
}
