import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
          Text("กรุณาป้อนรหัสผ่าน"),
          PinCodeTextField(
            appContext: context,
            length: 6,
            obscureText: true,
            useHapticFeedback: true,
            hapticFeedbackTypes: HapticFeedbackTypes.heavy,
            animationType: AnimationType.fade,
            animationDuration: Duration(milliseconds: 150),
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              inactiveColor: Colors.black,
            ),
            onChanged: (value) {
              print(value);
            },
          ),
        ],
      ),
    );
  }
}
