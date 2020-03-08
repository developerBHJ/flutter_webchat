import 'package:flutter/material.dart';

import '../const.dart';

class IndexBar extends StatefulWidget {
  final void Function(String letter) indexBarCallBack;

  const IndexBar({Key key, this.indexBarCallBack}) : super(key: key);

  @override
  _IndexBarState createState() => _IndexBarState();
}

// 索引条选中
int selectedIndex(BuildContext context, Offset globalPosition) {
  RenderBox box = context.findRenderObject();
  //坐标转换，算出Y值！
  double offsetY = box.globalToLocal(globalPosition).dy;
  // 每一个item的高度
  var itemHeight = ScreenHeight(context) / 2 / INDEX_WORDS.length;
  // ~ 取整   clamp：限制最大值 最小值
  int index = (offsetY ~/ itemHeight).clamp(0, INDEX_WORDS.length - 1);
  return index;
}

class _IndexBarState extends State<IndexBar> {
  var _selectedIndex = -1;

  double _indicatorY = 0.0;
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  Widget build(BuildContext context) {
    final List<Widget> indexList = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      indexList.add(
        Expanded(
            child: Container(
                child: Text(
                  INDEX_WORDS[i],
                  style: TextStyle(fontSize: 10),
                ))),
      );
    }
    return Positioned(
      top: ScreenHeight(context) / 8,
      right: 0.0,
      width: 120,
      height: ScreenHeight(context) / 2,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment(0, _indicatorY),
            width: 100,
            child: _indicatorHidden == true ? null : Stack(
              alignment: Alignment(-0.2, 0),
              children: <Widget>[
                Image(image: AssetImage('images/气泡.png'),width: 60,),
                Text(_indicatorText,style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
                )
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              width: 20,
              child: Column(
                children: indexList,
              ),
            ),
            // 点击
            onVerticalDragDown: (DragDownDetails details) {
              int index = selectedIndex(context, details.globalPosition);
              if (index != _selectedIndex) {
                _selectedIndex = index;
                setState(() {});
                widget.indexBarCallBack(INDEX_WORDS[_selectedIndex]);
              }
              // 气泡显示
              _indicatorText = INDEX_WORDS[_selectedIndex];
              _indicatorY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
              _indicatorHidden = false;
              setState(() {});
            },
            // 拖拽
            onVerticalDragUpdate: (DragUpdateDetails details) {
              int index = selectedIndex(context, details.globalPosition);
              if (index != _selectedIndex) {
                _selectedIndex = index;
                setState(() {});
                widget.indexBarCallBack(INDEX_WORDS[_selectedIndex]);
              }
              // 气泡显示
              _indicatorText = INDEX_WORDS[_selectedIndex];
              _indicatorY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
              _indicatorHidden = false;
              setState(() {});
            },
            // 拖拽结束
            onVerticalDragEnd: (DragEndDetails details) {
              _selectedIndex = -1;
              _indicatorHidden = true;
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}

const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
