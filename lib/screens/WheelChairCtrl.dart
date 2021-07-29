import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/providers/BTProvider.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/providers/DeviceProvider.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/DiscoveryPage.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/PinCodeField.dart';
import 'package:provider/provider.dart';

class WheelChairCtrlPageBody extends StatefulWidget {
  const WheelChairCtrlPageBody({Key? key}) : super(key: key);

  @override
  _WheelChairCtrlPageBodyState createState() => _WheelChairCtrlPageBodyState();
}

class _WheelChairCtrlPageBodyState extends State<WheelChairCtrlPageBody> {
  bool _isBonded = false;
  bool _isConnected = false;
  bool _isActivated = false;
  bool _connectionInProgress = false;
  bool _emergencyActive = false;

  String statusDescribe() {
    if (!_isBonded)
      return "ตรวจไม่พบ";
    else if (!_isConnected)
      return "ยังไม่ได้เชื่อมต่อ";
    else if (!_isActivated)
      return "เชื่อมต่อแล้ว";
    else
      return "พร้อมใช้งาน";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:
          (BuildContext context, DeviceProvider deviceProvider, Widget? child) {
        BluetoothDevice? data = deviceProvider.getData();
        _isBonded = data != null;
        _isConnected = (data?.isConnected ?? false);

        return Consumer(builder:
            (BuildContext context, BTProvider btProvider, Widget? child) {
          _isConnected = btProvider.connected;
          _connectionInProgress = btProvider.connectionInProgress;
          _isActivated = btProvider.authenticated;

          if (btProvider.lastInput == "EMERGENCY") _emergencyActive = true;

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
                        Text(
                            "ชื่ออุปกรณ์: ${data.name ?? "เกิดข้อผิดพลาดขึ้น"}"),
                        Text("ที่อยู่อุปกรณ์: ${data.address}"),
                      ],
                    ),
              SizedBox(height: 20),
              // * Open BT Menu Button
              !_isConnected ? openBTMenuButton() : Container(),
              // * Connect Button
              (_isBonded && data != null)
                  ? connectButton(context, data)
                  : Container(),
              // * Turn on Device Button
              (_isConnected && !_isActivated) ? turnOnButton() : Container(),
              // * Turn off Device Button
              _isActivated ? turnOffButton(btProvider) : Container(),
              SizedBox(height: 30),
              _isActivated ? emergencyButton() : Container(),
            ],
          );
        });
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
    var _onPressedFunc = _isConnected
        ? _isActivated
            ? null
            : () {
                Provider.of<BTProvider>(context, listen: false).disconnect();
              }
        : () {
            Provider.of<BTProvider>(context, listen: false)
                .connect(address: device.address, feedbackContext: context);
          };
    if (!_isConnected && _connectionInProgress)
      return ElevatedButton(
        onPressed: null,
        child: FittedBox(
          child: Row(
            children: [
              SizedBox(
                child: CircularProgressIndicator(),
                height: 25,
                width: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text("กำลังเชื่อมต่อ..."),
            ],
          ),
        ),
      );
    else
      return ElevatedButton.icon(
        onPressed: _onPressedFunc,
        icon: Icon(_isConnected
            ? Icons.wifi_off
            : _connectionInProgress
                ? Icons.refresh
                : Icons.wifi),
        label: Text(_isConnected ? "หยุดเชื่อมต่อ" : "เชื่อมต่อรถเข็น"),
      );
  }

  Widget turnOnButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return PinCodeFieldPage();
            },
          ),
        );
      },
      icon: Icon(Icons.vpn_key),
      label: Text("เปิดใช้งานรถเข็น"),
    );
  }

  Widget turnOffButton(BTProvider btProvider) {
    return ElevatedButton.icon(
      onPressed: () {
        BTProvider provider = Provider.of<BTProvider>(context, listen: false);
        provider.sendMessage("POWER_OFF");
        Provider.of<DeviceProvider>(context, listen: false).setData(null);
        _isBonded = false;
        provider.disconnect();
      },
      icon: Icon(Icons.power_off),
      label: Text("ปิดระบบรถเข็น"),
    );
  }

  Widget emergencyButton() {
    return Column(
      children: [
        _emergencyActive
            ? Text(
                "โหมดฉุกเฉินกำลังถูกเปิดใช้งานอยู่...",
                style: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              )
            : Container(),
        ElevatedButton.icon(
          onPressed: _emergencyActive
              ? () {
                  Provider.of<BTProvider>(context, listen: false)
                      .sendMessage("CANCEL_EMERGENCY");
                  _emergencyActive = false;
                }
              : () {
                  Provider.of<BTProvider>(context, listen: false)
                      .sendMessage("EMERGENCY");
                  _emergencyActive = true;
                },
          icon: Icon(_emergencyActive ? Icons.stop : Icons.add_alert),
          label: Text(
            _emergencyActive ? "หยุด" : "ขอความช่วยเหลือ",
            style: TextStyle(fontSize: 22),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.red[400]),
        ),
      ],
    );
  }
}
