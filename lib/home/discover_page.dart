import 'package:flutter/material.dart';
import 'full_width_button.dart';
import 'constants.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  static const SEPARATE_SIZE = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.BackgroundColor),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FullWidthButton(
                onPressed: () {},
                title: '朋友圈',
                iconPath: 'assets/images/ic_social_circle.png'),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
                onPressed: () {},
                title: '扫一扫',
                iconPath: 'assets/images/ic_quick_scan.png', showDivider: true,),
            FullWidthButton(
                onPressed: () {},
                title: '摇一摇',
                iconPath: 'assets/images/ic_shake_phone.png', showDivider: true),
            FullWidthButton(
                onPressed: () {},
                title: '看一看',
                iconPath: 'assets/images/ic_feeds.png'),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
                onPressed: () {},
                title: '搜一搜',
                iconPath: 'assets/images/ic_quick_search.png'),
            SizedBox(height: SEPARATE_SIZE),
          ],
        ),
      ),
    );
  }
}
