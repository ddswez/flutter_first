import 'package:flutter/material.dart';
import 'constants.dart';
import '../model/conversation.dart';

class _ConversationItem extends StatelessWidget {
  _ConversationItem({Key key, this.conversation, this.tapPos});

  final Conversation conversation;
  var tapPos;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(AppColors.ConversationItemBackgroundColor),
        border: Border(
          bottom: BorderSide(
            color: Color(AppColors.DividerColor),
            width: Constants.DividerWidth
          )
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/default_nor_avatar.png',
              width: Constants.ConversationAvatarSize,
              height: Constants.ConversationAvatarSize),
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
          Column(
            children: <Widget>[Text(conversation.updateAt, style: AppStyles.DesStyle)],
          )
        ],
      ),
    );
  }
}

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _ConversationItem(
              conversation: ConversationPageData.mockConversations[index]);
        },
        itemCount: ConversationPageData.mockConversations.length,
      ),
    );
  }
}
