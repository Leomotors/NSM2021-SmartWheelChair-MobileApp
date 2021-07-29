import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BTProvider with ChangeNotifier {
  bool _connected = false;
  bool _connectionInProgress = false;
  String lastInput = "";
  BluetoothConnection? connection;

  bool _isUserWhoDisconnect = false;

  bool get connected => _connected;
  bool get connectionInProgress => _connectionInProgress;

  String getData() {
    return lastInput;
  }

  void connect(
      {required String address, required BuildContext feedbackContext}) async {
    if (_connected || _connectionInProgress) {
      print("Ignored Connection Request");
      return;
    }
    _connectionInProgress = true;
    notifyListeners();

    try {
      BluetoothConnection.toAddress(address).then((_connection) {
        connection = _connection;
        _connectionInProgress = false;
        _isUserWhoDisconnect = false;

        if (connection != null) {
          _connected = true;
          ScaffoldMessenger.of(feedbackContext).showSnackBar(SnackBar(
            content: Text("การเชื่อมต่อสำเร็จ"),
          ));

          notifyListeners();
          sendMessage("Hello World!");

          connection?.input?.listen((Uint8List data) {
            String incoming = ascii.decode(data);
            print('Data incoming: $incoming');
            lastInput = incoming;

            notifyListeners();
            //connection.output.add(data); // Sending data

            if (incoming.contains('!')) {
              connection?.finish(); // Closing connection
              print('Disconnecting by local host');
            }
          }).onDone(() {
            _connected = false;
            if (!_isUserWhoDisconnect)
              showDialog(
                context: feedbackContext,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("เกิดข้อผิดพลาด"),
                    content: Text(
                        "การเชื่อมต่อถูกตัด กรุณาลองเชื่อมต่อใหม่อีกครั้ง"),
                    actions: [
                      ElevatedButton(
                        child: Text("รับทราบ"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            notifyListeners();
            print('Disconnected by remote request');
          });
        } else {
          print("Connection failed");
        }
      });
    } catch (ex) {
      showDialog(
          context: feedbackContext,
          builder: (_) {
            return AlertDialog(
              title: Text("Error"),
              actions: [Text("Ok")],
            );
          });
    }
  }

  void disconnect() {
    _isUserWhoDisconnect = true;
    connection?.finish();
    connection = null;
    _connected = false;
    notifyListeners();
  }

  void sendMessage(String text) async {
    text = text.trim();

    if (connection == null) return;

    if (text.length > 0) {
      try {
        connection?.output.add(ascii.encode(text + "\n"));
        await connection?.output.allSent;
      } catch (e) {
        print("Send Message failed");
      }
    }
  }
}
