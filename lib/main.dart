import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Wheel Chair Controller",
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: "Anakotmai",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Wheel Chair Controller")),
      ),
      // * FONT TEST
      body: Center(
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                  "https://cf.shopee.co.th/file/073e7558f5f45e28e87fcd6bb82f3130",
                  scale: 1.8),
            ),
            Text(
              "ครับ สำหรับท่านที่เดินผ่านไปผ่านมา วันนี้เฉาก๊วยชากังราวได้มาบริการท่านพ่อแม่พี่น้องกันอีกแล้วนะครับ อากาศร้อนๆอย่างนี้นะครับ เฉาก๊วยสักถ้วยชื่นใจ แม้อากาศไม่ร้อนก็ทานกันได้นะครับ เฉาก๊วยชากังราวนั้นทานได้ทุกฤดูกาลนะครับ นอกจากเฉาก๊วยชากังราวจะอร่อยแล้ว ก็ยังมีประโยชน์ต่อร่างกายอีกมากมาย เช่น แก้ร้อนใน แก้ไข้หวัด ลดความดันโลหิตสูง แก้กล้ามเนื้ออักเสบ ข้ออักเสบ ตับอักเสบ แล้วก็เบาหวาน และสำหรับท่านที่ไม่เคยเห็นต้นเฉาก๊วย วันนี้โอกาสดีนะครับ เรามีต้นเฉาก๊วยมาให้พ่อแม่พี่น้องได้ดูได้ชมกันด้วยนะครับ โอกาศหน้าอย่าลืมนะครับ เฉาก๊วยชากังราวแท้ๆที่เราทำจากยางเฉาก๊วยจริงๆนะครับ",
              style: TextStyle(fontSize: 14),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          launch("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
        },
        child: Icon(Icons.accessible),
        tooltip: "สวัสดีครับ",
      ),
    );
  }
}
