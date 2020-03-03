import 'package:flutter/material.dart';
import 'dicover_detail.dart';

class DiscoverCell extends StatefulWidget {
  final String title;
  final String subTitle;
  final String imageName;
  final String subImageName;

  const DiscoverCell(
      {Key key,
      @required this.title, // 必传参数
      @required this.subTitle,
      this.imageName,
      this.subImageName})
      : assert(title != null, 'title 不能为空'),
        // 断言 错误提示
        assert(imageName != null, 'imageName 不能为空');

  @override
  _DiscoverCellState createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  Color _themeColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DicoverDetailView(
                  title: widget.title,
                )));
        setState(() {
          _themeColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _themeColor = Colors.grey;
        });
      },
      onTapCancel: () {
        setState(() {
          _themeColor = Colors.white;
        });
      },
      child: Container(
        color: _themeColor,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 两端
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(widget.imageName),
                    width: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ), // left
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text(
                    widget.subTitle != null ? widget.subTitle : '',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  widget.subImageName != null
                      ? Container(
                          child: Image(
                            image: AssetImage(widget.subImageName),
                            width: 15,
                          ),
                          margin: EdgeInsets.only(left: 10, right: 10),
                        )
                      : Container(),
                  Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 15,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
