import 'package:flutter/material.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';

class WheelChairCtrl extends StatefulWidget {
  const WheelChairCtrl({Key? key}) : super(key: key);

  @override
  _WheelChairCtrlState createState() => _WheelChairCtrlState();
}

class _WheelChairCtrlState extends State<WheelChairCtrl> {
  String _status = "ไม่ได้เชื่อมต่อ";

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
          "สถานะรถเข็น: " + _status,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _status = "กดปุ่มแล้ว";
            });
          },
          child: Text("これがปุ่มだ"),
        ),
      ],
    );
  }
}
