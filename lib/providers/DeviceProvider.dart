import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DeviceProvider with ChangeNotifier{
  BluetoothDevice? _data;

  BluetoothDevice? getData(){
    return _data;
  }

  void setData(BluetoothDevice data)
  {
    _data = data;
    notifyListeners();
  }
}