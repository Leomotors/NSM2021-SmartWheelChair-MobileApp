import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BTProvider with ChangeNotifier {
  bool _connected = false;
  String lastInput = "";

  void connect(
      {required String address, required BuildContext feedbackContext}) async {
    BluetoothConnection connection =
        await BluetoothConnection.toAddress(address);
    _connected = true;

    ScaffoldMessenger.of(feedbackContext).showSnackBar(SnackBar(
      content: Text("การเชื่อมต่อสำเร็จ"),
    ));

    connection.input?.listen((Uint8List data) {
      String incoming = ascii.decode(data);
      print('Data incoming: ${incoming}');
      lastInput = incoming;

      notifyListeners();
      //connection.output.add(data); // Sending data

      if (incoming.contains('!')) {
        connection.finish(); // Closing connection
        print('Disconnecting by local host');
      }
    }).onDone(() {
      _connected = false;
      print('Disconnected by remote request');
    });
  }

  String getData() {
    return lastInput;
  }
}
