import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_webchat/chat/chat_data.dart';
import 'search_bar.dart';

class SearchPage extends StatefulWidget {
  final List<Chat> datas;

  const SearchPage({Key key, this.datas}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Chat> _modals = []; // 搜索的数据数组
  String _searchStr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(
            onChanged: (String str) {
              _searchData(str);
            },
          ),
          Expanded(
              flex: 1,
              child: NotificationListener(
                  onNotification: (ScrollNotification notification) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: ListView.builder(
                    itemBuilder: _itemForRow,
                    itemCount: _modals.length,
                  )))
        ],
      ),
    );
  }

  /*数据检索*/
  Void _searchData(String str) {
    if (str.length == 0) {
      _modals = [];
    } else {
      _modals.clear();
      for (int i = 0; i < widget.datas.length; i++) {
        if (widget.datas[i].name.contains(str)) {
          _modals.add(widget.datas[i]);
        }
      }
    }
    _searchStr = str;
    print(_modals);
    setState(() {});
  }

  /*创建列表item*/
  Widget _itemForRow(BuildContext context, int index) {
    return ListTile(
      title: _attTitle(_modals[index].name), //
      subtitle: Container(
        height: 20,
        width: 20,
        child: Text(
          _modals[index].message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_modals[index].imageUrl),
      ),
    );
  }

  /*富文本处理*/
  Widget _attTitle(String str) {
    TextStyle normalStyle = TextStyle(color: Colors.black, fontSize: 16);
    TextStyle highlighStyle = TextStyle(color: Colors.green, fontSize: 16);
    List<TextSpan> spans = [];
    // 找到需要高亮显示的字符
    List<String> strs = str.split(_searchStr);
    for (int i = 0; i < strs.length; i++) {
      String tempStr = strs[i];
      if (tempStr == '' && i < strs.length - 1) {
        spans.add(TextSpan(text: _searchStr, style: highlighStyle));
      } else {
        spans.add(TextSpan(text: str, style: normalStyle));
        if (i < strs.length - 1) {
          spans.add(TextSpan(text: _searchStr, style: highlighStyle));
        }
      }
    }
    return RichText(text: TextSpan(children: spans));
  }
}
