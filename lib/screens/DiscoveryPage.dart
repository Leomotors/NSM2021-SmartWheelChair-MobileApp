// * https://github.com/edufolly/flutter_bluetooth_serial/tree/master/example

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/constants/app_constants.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/providers/DeviceProvider.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/widgets/BluetoothDeviceListEntry.dart';
import 'package:provider/provider.dart';

class DiscoveryPage extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;

  const DiscoveryPage({this.start = true});

  @override
  _DiscoveryPage createState() => new _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;

  _DiscoveryPage();

  @override
  void initState() {
    super.initState();

    isDiscovering = widget.start;
    if (isDiscovering) {
      _startDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    FlutterBluetoothSerial.instance.requestEnable();
    try {
      _streamSubscription =
          FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
        setState(() {
          final existingIndex = results.indexWhere(
              (element) => element.device.address == r.device.address);
          if (existingIndex >= 0)
            results[existingIndex] = r;
          else
            results.add(r);
        });
      });

      _streamSubscription!.onDone(() {
        setState(() {
          isDiscovering = false;
        });
      });
    } catch (_) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("??????????????????????????????????????????????????????"),
              content: Text("??????????????????????????????????????????????????????????????????????????????????????????????????????"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("?????????????????????"),
                ),
              ],
            );
          });
    }
  }

  // @TODO . One day there should be `_pairDevice` on long tap on something... ;)

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isDiscovering
            ? Text('???????????????????????????????????????????????????')
            : Text('????????????????????????????????????????????????'),
        actions: <Widget>[
          isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: new EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("?????????????????????????????????????????????????????????????????????????????????????????????????????????"),
                Text("??????????????????????????????????????? ???????????? ???????????????????????????????????????????????????????????????"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (BuildContext context, index) {
                BluetoothDiscoveryResult result = results[index];
                final device = result.device;
                final address = device.address;
                // * Only show device with BT Module Name
                if (device.name?.contains(wheelChairBTModuleName) ?? false) {
                  return BluetoothDeviceListEntry(
                    device: device,
                    rssi: result.rssi,
                    onTap: () async {
                      try {
                        bool bonded = false;
                        // * If already bonded, exit
                        if (device.isBonded) {
                          provideDataToProvider(result.device);
                          return Navigator.of(context).pop(result.device);
                        }
                        // * Else pair and exit
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("????????????????????????????????? ${device.name}..."),
                          ));
                          bonded = (await FlutterBluetoothSerial.instance
                              .bondDeviceAtAddress(address))!;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "???????????????????????????????????? ${device.name} ${bonded ? '??????????????????' : '?????????????????????'}"),
                          ));
                          if (bonded) {
                            // * Bond Success
                            provideDataToProvider(result.device);
                            Navigator.of(context).pop(result.device);
                          }
                        }
                        setState(() {
                          results[results.indexOf(result)] =
                              BluetoothDiscoveryResult(
                                  device: BluetoothDevice(
                                    name: device.name ?? '',
                                    address: address,
                                    type: device.type,
                                    bondState: bonded
                                        ? BluetoothBondState.bonded
                                        : BluetoothBondState.none,
                                  ),
                                  rssi: result.rssi);
                        });
                      } catch (ex) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error occured while bonding'),
                              content: Text("${ex.toString()}"),
                              actions: <Widget>[
                                new TextButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    onLongPress: () async {
                      try {
                        // * If is bonded, unbond
                        if (device.isBonded) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("????????????????????????????????????????????? ${device.name}..."),
                          ));
                          await FlutterBluetoothSerial.instance
                              .removeDeviceBondWithAddress(address);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("?????????????????????????????? ${device.name} ??????????????????"),
                          ));
                          provideDataToProvider(null);
                        }
                        setState(() {
                          results[results.indexOf(result)] =
                              BluetoothDiscoveryResult(
                                  device: BluetoothDevice(
                                    name: device.name ?? '',
                                    address: address,
                                    type: device.type,
                                    bondState: BluetoothBondState.none,
                                  ),
                                  rssi: result.rssi);
                        });
                      } catch (ex) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('??????????????????????????????????????????????????????????????????'),
                              content: Text("${ex.toString()}"),
                              actions: <Widget>[
                                new TextButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void provideDataToProvider(BluetoothDevice? data) {
    DeviceProvider provider =
        Provider.of<DeviceProvider>(context, listen: false);
    provider.setData(data);
  }
}
