import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Wheel Chair Controller",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Smart Wheel Chair Controller"),
        ),
        // * FONT TEST
        body: Text(
            "ครับ สำหรับท่านที่เดินผ่านไปผ่านมา วันนี้เฉาก๊วยชากังราวได้มาบริการท่านพ่อแม่พี่น้องกันอีกแล้วนะครับ อากาศร้อนๆอย่างนี้นะครับ เฉาก๊วยสักถ้วยชื่นใจ แม้อากาศไม่ร้อนก็ทานกันได้นะครับ เฉาก๊วยชากังราวนั้นทานได้ทุกฤดูกาลนะครับ นอกจากเฉาก๊วยชากังราวจะอร่อยแล้ว ก็ยังมีประโยชน์ต่อร่างกายอีกมากมาย เช่น แก้ร้อนใน แก้ไข้หวัด ลดความดันโลหิตสูง แก้กล้ามเนื้ออักเสบ ข้ออักเสบ ตับอักเสบ แล้วก็เบาหวาน และสำหรับท่านที่ไม่เคยเห็นต้นเฉาก๊วย วันนี้โอกาสดีนะครับ เรามีต้นเฉาก๊วยมาให้พ่อแม่พี่น้องได้ดูได้ชมกันด้วยนะครับ โอกาศหน้าอย่าลืมนะครับ เฉาก๊วยชากังราวแท้ๆที่เราทำจากยางเฉาก๊วยจริงๆนะครับ"),
      ),
      theme: ThemeData(primarySwatch: Colors.yellow, fontFamily: "Anakotmai"),
    );
  }
}
