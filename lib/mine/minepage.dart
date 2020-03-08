import 'package:flutter/material.dart';
import 'package:flutter_webchat/discover/discover_cell.dart';
import '../const.dart';
import 'personal_center.dart';

class MineView extends StatefulWidget {
  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {

  final String _userName = '曲洛枫';
  final String _userNum = '微信号: bhjmoshangsao';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: ThemeColor,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: <Widget>[
                    headerView(), // 头部
                    SizedBox(height: 10,),
                    DiscoverCell(imageName: 'images/微信 支付.png', title: '支付',),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信收藏.png',
                      title: '收藏',
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            width: 50, height: 0.5, color: Colors.white),
                        Container(height: 0.5, color: Colors.grey)
                      ],
                    ), //分割线
                    DiscoverCell(
                      imageName: 'images/微信相册.png',
                      title: '相册',
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            width: 50, height: 0.5, color: Colors.white),
                        Container(height: 0.5, color: Colors.grey)
                      ],
                    ), //分割线
                    DiscoverCell(
                      imageName: 'images/微信卡包.png',
                      title: '卡包',
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            width: 50, height: 0.5, color: Colors.white),
                        Container(height: 0.5, color: Colors.grey)
                      ],
                    ), //分割线
                    DiscoverCell(
                      imageName: 'images/微信表情.png',
                      title: '表情',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信设置.png',
                      title: '设置',
                    ),
                  ],
                ),
              ),
            ), // 列表
            Container(
              margin: EdgeInsets.only(top: 44, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 靠右侧布局
                children: <Widget>[
                  Image(
                    image: AssetImage('images/相机.png'),
                    width: 25,
                  ),
                ],
              ),
            ), // 相机
          ],
        ),
      ),
    );
  }

  // 列表头部视图
  Widget headerView() {
    return Container(
      color: Colors.white,
      height: 200,
      child: Container(
        margin: EdgeInsets.only(top: 100),
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PersonalCenter()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image:
                        DecorationImage(image: AssetImage('images/header.png')),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 35,
                        child: Text(
                          _userName,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _userNum,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage('images/QRCode.png'),
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image(
                                    image: AssetImage('images/icon_right.png'),
                                    width: 15,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
