import 'package:flutter/material.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/app_constants.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/assets_path.dart';
import 'package:url_launcher/url_launcher.dart';

void myAboutDialog(BuildContext context, String _appVersion) => showAboutDialog(
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
          child: FlutterLogo(style: FlutterLogoStyle.horizontal, size: 50),
        ),
      ],
    );
