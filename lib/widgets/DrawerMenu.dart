import 'package:flutter/material.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/WaitForBluetoothPage.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/utils/AboutDialog.dart';
import 'package:package_info/package_info.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String _appVersion = "Unable to load";

  @override
  void initState() {
    super.initState();
    getVersionNumberAndSet();
  }

  Future<void> getVersionNumberAndSet() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Text(
            "การตั้งค่า",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(color: Colors.green),
        ),
        ListTile(
          title: Text("เมนูจับคู่รถเข็น"),
          leading: Icon(Icons.bluetooth),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return WaitForBluetoothPage();
                },
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(color: Colors.grey, height: 2),
        ),
        ListTile(
          title: Text("เกี่ยวกับแอป"),
          leading: Icon(Icons.info),
          onTap: () {
            myAboutDialog(context, _appVersion);
          },
        ),
      ],
    ));
  }
}
