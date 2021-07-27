import 'package:flutter/material.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/app_constants.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/screens/PairWheelChair.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

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
            "Settings",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(color: Colors.green),
        ),
        ListTile(
          title: Text("จับคู่รถเข็น"),
          leading: Icon(Icons.search),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PairWheelChairPage();
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
            showAboutDialog(
              context: context,
              applicationVersion: "เวอร์ชั่น " + _appVersion,
              applicationIcon: Image.asset(appLogoLocation, height: 40),
              children: [
                Center(
                  child: InkWell(
                      child: Text(
                        "Visit GitHub Page",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        launch(githubLink);
                      }),
                ),
                SizedBox(height: 10),
                Text(
                  "Made possible with",
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      FlutterLogo(style: FlutterLogoStyle.horizontal, size: 50),
                ),
              ],
            );
          },
        ),
      ],
    ));
  }
}
