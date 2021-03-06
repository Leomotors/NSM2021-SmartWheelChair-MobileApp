import 'package:flutter/material.dart';
import 'package:nsm2021_smartwheelchair_mobileapp/providers/BTProvider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PinCodeFieldPage extends StatefulWidget {
  const PinCodeFieldPage({Key? key}) : super(key: key);

  @override
  _PinCodeFieldPageState createState() => _PinCodeFieldPageState();
}

class _PinCodeFieldPageState extends State<PinCodeFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เปิดใช้งานรถเข็น")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("กรุณาป้อนรหัสผ่าน",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: true,
              useHapticFeedback: true,
              hapticFeedbackTypes: HapticFeedbackTypes.heavy,
              animationType: AnimationType.fade,
              animationDuration: Duration(milliseconds: 150),
              keyboardType: TextInputType.number,
              autoFocus: true,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                inactiveColor: Colors.black,
              ),
              onChanged: (value) {
                print(value);
              },
              onCompleted: (value) {
                Provider.of<BTProvider>(context, listen: false)
                    .sendMessage(value);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
