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
        primarySwatch: Colors.blue,
        highlightColor: Color.fromRGBO(1, 0, 0, 0),
        splashColor: Color.fromRGBO(1, 0, 0, 0),
      ),
      home: RootView(),
    );
  }
}