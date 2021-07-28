import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BTConnection {
  
  void connect(
      {required String address, required BuildContext feedbackContext}) async {
    BluetoothConnection connection =
        await BluetoothConnection.toAddress(address);

    ScaffoldMessenger.of(feedbackContext).showSnackBar(SnackBar(
      content: Text("การเชื่อมต่อสำเร็จ"),
    ));

    connection.input?.listen((Uint8List data) {
      print('Data incoming: ${ascii.decode(data)}');
      connection.output.add(data); // Sending data

      if (ascii.decode(data).contains('!')) {
        connection.finish(); // Closing connection
        print('Disconnecting by local host');
      }
    }).onDone(() {
      print('Disconnected by remote request');
    });
  }
}
