import 'package:flutter/material.dart';
import 'constants.dart';
import '../model/conversation.dart';

class _ConversationItem extends StatelessWidget {
  _ConversationItem({Key key, this.conversation, this.tapPos});

  final Conversation conversation;
  var tapPos;

  @override
  Widget build(BuildContext context) {
    Widget avater;
    if (conversation.isAvatarFromNet()) {
      avater = Image.network(conversation.avatar,
          width: Constants.ConversationAvatarSize,
          height: Constants.ConversationAvatarSize);
    } else {
      avater = Image.asset(conversation.avatar,
          width: Constants.ConversationAvatarSize,
          height: Constants.ConversationAvatarSize);
    }

    Widget avatarContainer;
    if (conversation.unreadMsgCount > 0) {
      Widget unreadMsgCountText = Container(
        width: Constants.UnreadMsgNotifyDotSize,
        height: Constants.UnreadMsgNotifyDotSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(Constants.UnreadMsgNotifyDotSize / 2.0),
            color: Color(AppColors.NotifyDotBg)),
        child: Text(conversation.unreadMsgCount.toString(),
            style: AppStyles.UnreadMsgCountDotStyle),
      );

      avatarContainer = Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          avater,
          Positioned(top: -6.0, right: -6.0, child: unreadMsgCountText)
        ],
      );
    } else {
      avatarContainer = avater;
    }

    // 勿扰模式图标
    Widget muteIcon = Icon(
      IconData(0xe60f, fontFamily: Constants.IconFontFamily),
      color: Color(AppColors.ConversationMuteIcon),
      size: Constants.ConversationMuteIconSize,
    );
    var _rightArea = <Widget>[
      Text(conversation.updateAt, style: AppStyles.DesStyle),
      SizedBox(height: 10.0)
    ];
    if (conversation.isMute) {
      _rightArea.add(Icon(
        IconData(0xe60f, fontFamily: Constants.IconFontFamily),
        color: Color(AppColors.ConversationMuteIcon),
        size: Constants.ConversationMuteIconSize,
      ));
    } else {
      _rightArea.add(Icon(
        IconData(0xe60f, fontFamily: Constants.IconFontFamily),
        color: Colors.transparent,
        size: Constants.ConversationMuteIconSize,
      ));
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Color(AppColors.ConversationItemBackgroundColor),
          border: Border(
              bottom: BorderSide(
                  color: Color(AppColors.DividerColor),
                  width: Constants.DividerWidth))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          avatarContainer,
          Container(width: 10.0),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(conversation.title, style: AppStyles.TitleStyle),
              Text(conversation.des, style: AppStyles.DesStyle),
            ],
          )),
          Container(width: 10.0),
          Column(children: _rightArea)
        ],
      ),
    );
  }
}

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _DeviceInfoItem extends StatelessWidget {
  const _DeviceInfoItem({this.deviece}) : assert(deviece != null);

  final Device deviece;

  int get iconName {
    return deviece == Device.MAC ? 0xe640 : 0xe668;
  }

  String get deviceName {
    return deviece == Device.MAC ? "Mac" : "Windows";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 24.0, top: 10.0, bottom: 10.0, right: 24.0),
      decoration: BoxDecoration(
          color: Color(AppColors.DeviceInfoItemBg),
          border: Border(
              bottom: BorderSide(
                  color: Color(AppColors.DividerColor),
                  width: Constants.DividerWidth))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            IconData(iconName, fontFamily: Constants.IconFontFamily),
            size: 24.0,
            color: Color(AppColors.DeviceInfoItemIcon),
          ),
          SizedBox(width: 16.0),
          Text(
            '$deviceName 微信已登录, 手机通知已关闭',
            style: AppStyles.DeviceInfoItemTextStyle,
          )
        ],
      ),
    );
  }
}

class _ConversationPageState extends State<ConversationPage> {

  final ConversationPageData data = ConversationPageData.mock();

  @override
  Widget build(BuildContext context) {
    var mockConversations = data.conversations;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (data.device != null) {
          if (index == 0) {
            return _DeviceInfoItem(deviece: data.device);
          }
          return _ConversationItem(
              conversation: mockConversations[index -1]);
        } else {
          return _ConversationItem(
              conversation: mockConversations[index]);
        }

      },
      itemCount: data.device != null ? mockConversations.length + 1 : mockConversations.length,
    );
  }
}
