import 'package:flutter/material.dart';

class DicoverDetailView extends StatefulWidget {

  final String title;

  const DicoverDetailView({Key key, this.title}) : super(key: key);

  @override
  _DicoverDetailViewState createState() => _DicoverDetailViewState();
}

class _DicoverDetailViewState extends State<DicoverDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
