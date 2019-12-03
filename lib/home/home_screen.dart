import 'package:flutter/material.dart';
import 'constants.dart' show Constants;

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
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
          title: '微信',
          icon: IconData(
              0xe615,
              fontFamily: Constants.IconFontFamily),
          activeIcon: IconData(0xe62f,
              fontFamily: Constants.IconFontFamily)),
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
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('on click search');
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print('on click add');
            },
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
