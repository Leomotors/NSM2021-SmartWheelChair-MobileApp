import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Wheel Chair Controller",
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: "Anakotmai",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _sendToRickURL = "https://www.youtube.com/watch?v=j8PxqgliIno";
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
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Wheel Chair Controller",
            style: TextStyle(fontSize: 19),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationVersion: "เวอร์ชั่น " + _appVersion,
                  applicationIcon: Image.asset(appLogoLocation, height: 40),
                  children: [
                    Text(
                      "Made possible with",
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlutterLogo(
                          style: FlutterLogoStyle.horizontal, size: 50),
                    ),
                  ],
                );
              },
              icon: Icon(Icons.info)),
        ],
      ),
      body: Text("Nothing here"),
    );
  }
}
