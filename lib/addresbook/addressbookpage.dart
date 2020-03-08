import 'package:flutter/material.dart';
import 'contacts.dart';
import '../const.dart';
import 'package:flutter_webchat/discover/dicover_detail.dart';
import 'index_bar.dart';

class AddressBookView extends StatefulWidget {
  @override
  _AddressBookViewState createState() => _AddressBookViewState();
}

class _AddressBookViewState extends State<AddressBookView> {
  final List<Contacts> _listDatas = [];
  // 控制ListView滚动
  ScrollController _scrollController;
  var _totalOffSet = 0.0;
  // 保存每个cell的位置
  final Map _groupOffsetMap = { // 搜索和搜藏默认为0
    INDEX_WORDS[0] : 0.0,
    INDEX_WORDS[1] : 0.0,
  };

  @override
  void initState() {
    // TODO: implement initState
    _listDatas..addAll(contacts_list)..addAll(contacts_list);
    _listDatas.sort((Contacts a, Contacts b) {
      return a.indexLetter.compareTo(b.indexLetter); // 首字母排序
    });
    _scrollController = ScrollController();
    //创建字母对应OffSet的Map
    var _groupOffSet = 54.0 * 4;
    _totalOffSet += _groupOffSet;
    for (int i = 0; i < _listDatas.length; i++){
      if(i < 1){
        _groupOffsetMap.addAll({_listDatas[i].indexLetter : _groupOffSet});
        _groupOffSet += 84.0;
        _totalOffSet += 84.0;
      }else if (_listDatas[i].indexLetter == _listDatas[i - 1].indexLetter){// 不需要显示分区头
        _groupOffSet += 54.0;
        _totalOffSet += 54.0;
      }else{
        _groupOffsetMap.addAll({_listDatas[i].indexLetter : _groupOffSet});
        _groupOffSet += 84.0;
        _totalOffSet += 84.0;
      }
    }
  }

  final List<Contacts> _headerData = [
    Contacts(imageUrl: 'images/新的朋友.png', name: '新的朋友'),
    Contacts(imageUrl: 'images/群聊.png', name: '群聊'),
    Contacts(imageUrl: 'images/标签.png', name: '标签'),
    Contacts(imageUrl: 'images/公众号.png', name: '公众号'),
  ];

  final List<String> IndexBarData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通讯录'),
        backgroundColor: ThemeColor,
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image(image: AssetImage('images/icon_friends_add.png')),
              width: 25,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DicoverDetailView(
                    title: '添加好友',
                  )));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: ThemeColor,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _listDatas.length + _headerData.length,
              itemBuilder: _cellForRow,
            ),
          ),
          IndexBar(
            indexBarCallBack: (String letter){
              if(_groupOffsetMap[letter] != null){
                _scrollController.animateTo(
                    _groupOffsetMap[letter],
                    duration: Duration(milliseconds: 10),
                    curve: Curves.easeIn);
              }
            },
          ),// 索引条
        ],
      ),
    );
  }

  Widget _cellForRow(BuildContext context, int index) {
    if (index < _headerData.length) {
      return ContactsCell(
        imageAssets: _headerData[index].imageUrl,
        name: _headerData[index].name,
      );
    }
    ;

    if (index > 4 &&
        _listDatas[index - 4].indexLetter ==
            _listDatas[index - 5].indexLetter) {
      return ContactsCell(
        imageUrl: _listDatas[index - 4].imageUrl,
        name: _listDatas[index - 4].name,
      );
    }
    return ContactsCell(
      imageUrl: _listDatas[index - 4].imageUrl,
      name: _listDatas[index - 4].name,
      groupTitle: _listDatas[index - 4].indexLetter,
    );
  }
}

class ContactsCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;

  const ContactsCell(
      {Key key, this.imageUrl, this.name, this.groupTitle, this.imageAssets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // 分区头部
          Container(
            color: Color.fromRGBO(1, 1, 1, 0.0),
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            // groupTitle需要显示时才显示
            height: groupTitle != null ? 30 : 0,
            child: groupTitle != null
                ? Text(
              groupTitle,
              style: TextStyle(color: Colors.grey),
            )
                : null,
          ),
          GestureDetector(
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  // 用户图片
                  Container(
                    height: 34,
                    width: 34,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        // 加载网络图片或本地图片
                        image: DecorationImage(
                          image: imageUrl != null
                              ? NetworkImage(imageUrl)
                              : AssetImage(imageAssets),
                        )),
                  ),
                  Container(
                    height: 54,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: ScreenWidth(context) - 54,
                          height: 53.5,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        // 分割线
                        Container(
                          height: 0.5,
                          color: ThemeColor,
                          width: ScreenWidth(context) - 54,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DicoverDetailView(
                    title: name,
                  )));
            },
          )
        ],
      ),
    );
  }
}
