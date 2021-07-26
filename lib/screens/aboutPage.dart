import 'package:flutter/material.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final double _appNameFontSize = 22;
  final double _appVersionFontSize = 18;

  @override
  void initState() {
    super.initState();
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About App"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Image.asset(
                  appLogoLocation,
                  height: 150,
                ),
              ),
            ),
            Text(
              "Wheel Chair Controller",
              style: TextStyle(
                  fontSize: _appNameFontSize, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            FutureBuilder(
              future: getAppVersion(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var result = snapshot.data;
                  return Text(
                    "เวอร์ชั่น " + result,
                    style: TextStyle(fontSize: _appVersionFontSize),
                  );
                }
                return Text("กำลังโหลดข้อมูลเวอร์ชั่น",
                    style: TextStyle(fontSize: _appVersionFontSize));
              },
            ),
          ],
        ));
  }
}
