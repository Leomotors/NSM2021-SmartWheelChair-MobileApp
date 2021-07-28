import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/providers/DeviceProvider.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/DiscoveryPage.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/utils/BTConnection.dart';
import 'package:provider/provider.dart';

class WheelChairCtrlPageBody extends StatefulWidget {
  const WheelChairCtrlPageBody({Key? key}) : super(key: key);

  @override
  _WheelChairCtrlPageBodyState createState() => _WheelChairCtrlPageBodyState();
}

class _WheelChairCtrlPageBodyState extends State<WheelChairCtrlPageBody> {
  bool _isBonded = false;
  bool _isConnected = false;
  BTConnection connection = BTConnection();

  String statusDescribe() {
    if (!_isBonded)
      return "ตรวจไม่พบ";
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
        _isBonded = data != null;
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
                      Text("ชื่ออุปกรณ์: ${data.name ?? "เกิดข้อผิดพลาดขึ้น"}"),
                      Text("ที่อยู่อุปกรณ์: ${data.address}"),
                    ],
                  ),
            SizedBox(height: 20),
            // * Open BT Menu Button
            !_isBonded ? openBTMenuButton() : Container(),
            // * Connect Button
            (_isBonded && !_isConnected && data != null)
                ? connectButton(context, data)
                : Container(),
            // * Turn on Device Button
            turnOnButton(),
            // * Turn off Device Button
            _isConnected ? turnOffButton() : Container(),
            SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add_alert),
              label: Text(
                "ขอความช่วยเหลือ",
                style: TextStyle(fontSize: 22),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.red[400]),
            )
          ],
        );
      },
    );
  }

  Widget openBTMenuButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return DiscoveryPage();
            },
          ),
        );
      },
      icon: Icon(Icons.bluetooth),
      label: Text("เปิดเมนูจับคู่รถเข็น"),
    );
  }

  Widget connectButton(BuildContext context, BluetoothDevice device) {
    return ElevatedButton.icon(
      onPressed: _isConnected
          ? () {}
          : () {
              connection.connect(
                  address: device.address, feedbackContext: context);
            },
      icon: Icon(_isConnected ? Icons.wifi_off : Icons.wifi),
      label: Text(_isConnected ? "หยุดเชื่อมต่อ" : "เชื่อมต่อรถเข็น"),
    );
  }

  Widget turnOnButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.vpn_key),
      label: Text("เปิดใช้งานรถเข็น"),
    );
  }

  Widget turnOffButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.power_off),
      label: Text("ปิดระบบรถเข็น"),
    );
  }
}
