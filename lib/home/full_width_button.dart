import 'package:flutter/material.dart';
import 'constants.dart';

class FullWidthButton extends StatelessWidget {

  const FullWidthButton(
      {@required this.onPressed, @required this.title, @required this.iconPath, this.showDivider: false})
      : assert(iconPath != null),
        assert(title != null),
        assert(onPressed != null);

  final String iconPath;
  final String title;
  final bool showDivider;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    final pureButton = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          iconPath,
          width: Constants.FullWidthIconButtonIconSize,
          height: Constants.FullWidthIconButtonIconSize,
        ),
        SizedBox(width: 16.0),
        Text(title)
      ],
    );

    final borderedButton = Container(
      child: pureButton,
      padding: EdgeInsets.only(bottom: 13.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(AppColors.DividerColor), width: Constants.DividerWidth)
        ),
      ),
    );

    return FlatButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: onPressed,
      color: Colors.white,
      padding: EdgeInsets.only(left: 16.0, top: 13.0, right: 16.0, bottom: showDivider ? 0.0 : 13.0),
      child: showDivider ? borderedButton: pureButton,
    );
  }
}
