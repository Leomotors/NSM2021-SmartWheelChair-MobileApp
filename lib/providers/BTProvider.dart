import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:url_launcher/url_launcher.dart';

class BTProvider with ChangeNotifier {
  bool _connected = false;
  bool _connectionInProgress = false;
  bool _authenticated = false;
  String lastInput = "";
  BluetoothConnection? connection;
  String deviceID = "";

  bool _isUserWhoDisconnect = false;

  bool get connected => _connected;
  bool get connectionInProgress => _connectionInProgress;
  bool get authenticated => _authenticated;

  String buffer = "";

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
          sendMessage("ID_QUERY");

          connection?.input
              ?.listen(_onDataRecieved(feedbackContext))
              .onDone(() {
            _connected = false;
            _authenticated = false;
            lastInput = "";
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

  dynamic _onDataRecieved(BuildContext context) {
    return (Uint8List data) {
      String incoming = ascii.decode(data);
      print('Data pocket: $incoming with size of ${incoming.length}');

      buffer += incoming;
      if (buffer[buffer.length - 1] == '\n') {
        lastInput = buffer.trim();
        buffer = "";
        print('Data Arrived: ${lastInput.replaceAll('\r', "")}');
        _dataProcess(lastInput, context);
        notifyListeners();
      }
    };
  }

  void _dataProcess(String data, BuildContext context) {
    if (data == "AUTH=SUCCESS") _authenticated = true;
    if (data == "AUTH=FAILED") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("รหัสผ่านไม่ถูกต้อง"),
      ));
      launch("https://www.youtube.com/watch?v=j8PxqgliIno");
    }
    if (data.startsWith("DEVICEID=")) {
      deviceID = data.replaceAll("DEVICEID=", "");
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
        print(ascii.encode(text + "\n"));
        connection?.output.add(ascii.encode(text + "\n"));
        await connection?.output.allSent;
      } catch (e) {
        print("Send Message failed");
      }
    }
  }
}
