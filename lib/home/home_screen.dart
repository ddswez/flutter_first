import 'package:flutter/material.dart';
import 'constants.dart';
import 'conversation_page.dart';
import 'contacts_page.dart';
import 'discover_page.dart';
import 'package:flutter/services.dart';
import 'functions_page.dart';

enum ActionItems { GROUP_CHAT, QR_SACN, ADD_FRIEND, PAYMENT, HELP }

class NavigationIconView {
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData icon, IconData activeIcon})
      : item = new BottomNavigationBarItem(
            icon: Icon(icon),
            activeIcon: Icon(activeIcon),
            title: Text(title),
            backgroundColor: Colors.white);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  List<NavigationIconView> _navigationViews;
  int _currentIndex = 0;
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
          title: '微信',
          icon: IconData(0xe615, fontFamily: Constants.IconFontFamily),
          activeIcon: IconData(0xe62f, fontFamily: Constants.IconFontFamily)),
      NavigationIconView(
          title: '通讯录',
          icon: IconData(0xe63a, fontFamily: Constants.IconFontFamily),
          activeIcon: IconData(0xe6c2, fontFamily: Constants.IconFontFamily)),
      NavigationIconView(
          title: '发现',
          icon: IconData(0xe612, fontFamily: Constants.IconFontFamily),
          activeIcon: IconData(0xe6d6, fontFamily: Constants.IconFontFamily)),
      NavigationIconView(
          title: '我',
          icon: IconData(0xe758, fontFamily: Constants.IconFontFamily),
          activeIcon: IconData(0xe607, fontFamily: Constants.IconFontFamily)),
    ];
    _pageController = PageController(initialPage: _currentIndex);

    _pages = [
      ConversationPage(),
      ContactsPage(),
      DiscoverPage(),
      FunctionsPage(),
    ];
  }

  _buildPopupMenuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Icon(
          IconData(iconName, fontFamily: Constants.IconFontFamily),
          size: 22.0,
          color: const Color(AppColors.AppBarPopupMenuColor),
        ),
        Container(width: 12.0),
        Text(
          title,
          style: TextStyle(color: const Color(AppColors.AppBarPopupMenuColor)),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent
    ));
    final BottomNavigationBar _bottomBar = BottomNavigationBar(
      fixedColor: const Color(AppColors.TabIconActive),
      selectedFontSize: 12.0,
      items: _navigationViews
          .map((NavigationIconView navigationIconView) =>
              navigationIconView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;

          _pageController.animateToPage(_currentIndex,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("微信", style: AppStyles.TitleStyle),
        elevation: 0,
        brightness: Brightness.light,

        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.search, color: Color(AppColors.ActionIconColor)),
              onPressed: () {
                print('on click search');
              },
            ),
          ),

          Theme(
            data: ThemeData(
              cardColor: Color(AppColors.ActionMenuBgColor)
            ),
            child: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<ActionItems>>[
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe62f, '发起群聊'),
                    value: ActionItems.GROUP_CHAT,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe61d, '添加朋友'),
                    value: ActionItems.ADD_FRIEND,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe613, '扫一扫'),
                    value: ActionItems.QR_SACN,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe64d, '收付款'),
                    value: ActionItems.PAYMENT,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem(0xe6b3, '帮助与反馈'),
                    value: ActionItems.HELP,
                  ),
                ];
              },
              icon: Icon(Icons.add, color: Color(AppColors.ActionIconColor)),
              onSelected: (ActionItems selected) {
                print('on click is $selected');
              },
            ),
          ),

          // 右边距
          Container(
            width: 16.0,
          )
        ],
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        itemCount: _pages.length,
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: _bottomBar,
    );
  }
}
