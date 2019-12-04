import 'package:flutter/material.dart';
import 'constants.dart' show Constants, AppColors;

enum ActionItems { GROUP_CHAT, QR_SACN, ADD_FRIEND, PAYMENT, HELP }

class NavigationIconView {
  final String _title;
  final IconData _icon;
  final IconData _activeIcon;
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData icon, IconData activeIcon})
      : _title = title,
        _icon = icon,
        _activeIcon = activeIcon,
        item = new BottomNavigationBarItem(
            icon: Icon(
              icon,
              color: Color(AppColors.TabIconNormal),
            ),
            activeIcon: Icon(
              activeIcon,
              color: Color(AppColors.TabIconActive),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 14.0, color: Color(AppColors.TabIconNormal)),
            ),
            backgroundColor: Colors.white);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavigationIconView> _navigationViews;

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
    final BottomNavigationBar _bottomBar = BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationIconView) =>
              navigationIconView.item)
          .toList(),
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        print('点击的是第$index个');
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("微信"),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('on click search');
              },
            ),
          ),
          PopupMenuButton(
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
            icon: Icon(Icons.add),
            onSelected: (ActionItems selected) {
              print('on click is $selected');
            },
          ),
          // 右边距
          Container(
            width: 16.0,
          )
        ],
      ),
      body: Container(
        color: Colors.red,
      ),
      bottomNavigationBar: _bottomBar,
    );
  }
}
