import 'package:flutter/material.dart';

class NavigationIconView {
  final String _title;
  final Widget _icon;
  final Widget _activeIcon;
  final BottomNavigationBarItem item;

  NavigationIconView({Key key, String title, Widget icon, Widget activeIcon})
      : _title = title,
        _icon = icon,
        _activeIcon = activeIcon,
        item = new BottomNavigationBarItem(
            icon: icon,
            activeIcon: activeIcon,
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
          icon: Icon(Icons.ac_unit),
          activeIcon: Icon(Icons.access_alarm)),
      NavigationIconView(
          title: '通讯录', icon: Icon(Icons.print), activeIcon: Icon(Icons.build)),
      NavigationIconView(
          title: '发现',
          icon: Icon(Icons.title),
          activeIcon: Icon(Icons.unfold_less)),
      NavigationIconView(
          title: '我',
          icon: Icon(Icons.tab),
          activeIcon: Icon(Icons.tab_unselected)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar _bottomBar = BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView navigationIconView) => navigationIconView.item).toList(),
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
