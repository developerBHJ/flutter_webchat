import 'package:flutter/material.dart';

class AddressBookView extends StatefulWidget {
  @override
  _AddressBookViewState createState() => _AddressBookViewState();
}

class _AddressBookViewState extends State<AddressBookView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通讯录'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
