import 'package:flutter/material.dart';
import 'root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter WebChat',
      theme: ThemeData(
        primarySwatch: Colors.yellow,// 暖色系 标题自动变为黑色，冷色系 标题自动变为白色
        highlightColor: Color.fromRGBO(1, 0, 0, 0),
        splashColor: Color.fromRGBO(1, 0, 0, 0),
        cardColor: Color.fromRGBO(1, 1, 1, 0.5),// PopupMenu 背景色
      ),
      home: RootView(),
    );
  }
}