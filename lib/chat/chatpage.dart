import 'package:flutter/material.dart';
import 'package:flutter_webchat/const.dart';
import 'dart:convert';
import 'chat_data.dart';
import 'package:http/http.dart' as http;

/* 混入（Mixins）
* 用来给类增加功能。with 混入一个或多个mixin
*/
class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with AutomaticKeepAliveClientMixin<ChatView>{

  List<Chat> _datas = [];

  bool _cancelConnect = false;//多次请求！

  @override
  void initState() {
    super.initState();
    // 数据请求
    getDataList().then((List<Chat> datas){
      if(!_cancelConnect){
        setState(() {
          _datas = datas;
        });
      }
    }).catchError((error){
      print('错误提示：${error}');
    }).whenComplete((){
      print('请求结束');
    }).timeout(Duration(seconds: 3)).catchError((timeout){
      _cancelConnect = true;
      print('超时:${timeout}');
    });
  }
  /*
  网络请求数据
  async 异步
  */
  Future <List<Chat>> getDataList() async {
    _cancelConnect = false;
    final response = await http.get('http://rap2api.taobao.org/app/mock/224518/api/chat/list');
    if(response.statusCode == 200){
      // 获取数据并解析
      final resonseBody = jsonDecode(response.body);
      // 转模型数组
      List <Chat> chatList = resonseBody['chat_list'].map<Chat>((item) => Chat.formJson(item)).toList();
      return chatList;
    }else{
      // 错误
      throw Exception('statusCode${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        backgroundColor: ThemeColor,
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: PopupMenuButton(
              itemBuilder:_popupMenuButtonBuild,
              offset: Offset(0, 64.0),
              child: Image(image: AssetImage('images/圆加.png'),width: 25,),
            ),
          ),
        ],
      ),
      body: Container(
        child: _datas.length == 0
            ? Center(
          child: Text('Loading..'),
        ) : ListView.builder(
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                title: Text(
                  _datas[index].name ,
                  style: TextStyle(
                      color: Colors.black ,
                      fontSize: 15) ,
                ) ,
                subtitle: Container(
                  height: 20,
                  width: 20,
                  child: Text(
                    _datas[index].message,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13
                    ),
                    overflow:
                    TextOverflow.ellipsis,
                  ),
                ),
                leading: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(_datas[index].imageUrl)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              );
            }),
      ),
    );
  }
  // 保存状态
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// 右上角弹出框
List<PopupMenuItem<String>> _popupMenuButtonBuild(BuildContext context){

  return <PopupMenuItem<String>>[
    _itemBuild('images/发起群聊.png', '发起群聊'),
    _itemBuild('images/添加朋友.png', '添加朋友'),
    _itemBuild('images/扫一扫1.png', '扫一扫'),
    _itemBuild('images/收付款.png', '收付款'),
  ];
}

PopupMenuItem<String> _itemBuild(String imagesName,String title){

  return PopupMenuItem(
      child: Row(
        children: <Widget>[
          Image(image: AssetImage(imagesName),width: 25,),
          Container(width: 20,),
          Text(title,style: TextStyle(fontSize: 15,color: Colors.white),),
        ],
      )
  );
}



