import 'package:flutter/material.dart';
import '../model/me.dart';
import 'constants.dart';
import 'full_width_button.dart';

class FunctionsPage extends StatefulWidget {
  @override
  _FunctionsPageState createState() => _FunctionsPageState();
}

class _FunctionsPageState extends State<FunctionsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.BackgroundColor),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _Header(),
            SizedBox(height: 16.0,),
            FullWidthButton(
                onPressed: () {},
                title: '钱包',
                iconPath: 'assets/images/ic_wallet.png'),
            SizedBox(height: 16.0,),
            FullWidthButton(
                onPressed: () {},
                title: '收藏',
                iconPath: 'assets/images/ic_collections.png', showDivider: true,),
            FullWidthButton(
                onPressed: () {},
                title: '相册',
                iconPath: 'assets/images/ic_album.png'),
            SizedBox(height: 16.0,),
            FullWidthButton(
              onPressed: () {},
              title: '设置',
              iconPath: 'assets/images/ic_settings.png', des: '账号为保护',),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      color: AppColors.HeaderCardBg,
      padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            me.avatar,
            width: 72.0,
            height: 72.0,
          ),
          SizedBox(width: 16.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  me.name,
                  style: AppStyles.HeaderCardTitleTextStyle,
                ),
                Text(
                  me.account,
                  style: AppStyles.HeaderCardDesTextStyle,
                ),
              ],
            ),
          ),
          Image.asset('assets/images/ic_qrcode_preview_tiny.png',
          width: 20.0, height: 20.0,)

        ],
      ),
    );
  }
}
