import 'package:flutter/material.dart';
import 'chat/chatpage.dart';
import 'addresbook/addressbookpage.dart';
import 'discover/discoverpage.dart';
import 'mine/minepage.dart';

class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  List<Widget> pages = [
    ChatView(),
    AddressBookView(),
    DiscoverView(),
    MineView()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('images/tabbar_chat.png'),
                height: 20,
                width: 20,
              ),
              title: Text('微信'),
              activeIcon: Image(
                image: AssetImage('images/tabbar_chat_hl.png'),
                height: 20,
                width: 20,
              ),
            ),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/tabbar_friends.png'),
                  height: 20,
                  width: 20,
                ),
                title: Text('通讯录'),
                activeIcon: Image(
                  image: AssetImage('images/tabbar_friends_hl.png'),
                  height: 20,
                  width: 20,
                )),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/tabbar_discover.png'),
                  height: 20,
                  width: 20,
                ),
                title: Text('发现'),
                activeIcon: Image(
                  image: AssetImage('images/tabbar_discover_hl.png'),
                  height: 20,
                  width: 20,
                )),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/tabbar_mine.png'),
                  height: 20,
                  width: 20,
                ),
                title: Text('我'),
                activeIcon: Image(
                  image: AssetImage('images/tabbar_mine_hl.png'),
                  height: 20,
                  width: 20,
                ))
          ],
          onTap: (int index) {
            _currentIndex = index;
            setState(() {});
            _pageController.jumpToPage(index);
          },
          selectedFontSize: 12,// 选中字体
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green,
          currentIndex: _currentIndex,
        ),
        body:
//        pages[_currentIndex]
        PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            ChatView(),
            AddressBookView(),
            DiscoverView(),
            MineView(),
          ],
        ),
      ),
    );
  }
}
