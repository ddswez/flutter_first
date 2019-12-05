import 'package:flutter/material.dart';
import '../model/contacts.dart';
import 'constants.dart';

class _ContactItem extends StatelessWidget {
  _ContactItem(
      {@required this.avatar,
      @required this.title,
      this.groupTitle,
      this.onPressed});

  final String avatar;
  final String title;
  final String groupTitle;
  final VoidCallback onPressed;

  static double BOTTON_HEIGH = 48.0;
  static double MARGIN_VERTICAL = 10.0;
  static double GROUP_TITLE_HEIGHT = 24.0;

  bool get _isAvatarFromNet {
    return this.avatar.startsWith('http') || this.avatar.startsWith('https');
  }

  static double _height(bool hasGroupTitle) {
    final _bottonHeight = MARGIN_VERTICAL * 2 +
        Constants.ContactAvatarSize +
        Constants.DividerWidth;
    if (hasGroupTitle) {
      return _bottonHeight + GROUP_TITLE_HEIGHT;
    }
    return _bottonHeight;
  }

  @override
  Widget build(BuildContext context) {
    // 联系人头像
    Widget _avatarIcon;
    if (_isAvatarFromNet) {
      _avatarIcon = Image.network(avatar,
          width: Constants.ContactAvatarSize,
          height: Constants.ContactAvatarSize);
    } else {
      _avatarIcon = Image.asset(avatar,
          width: Constants.ContactAvatarSize,
          height: Constants.ContactAvatarSize);
    }

    // 主体
    Widget _button = (Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Color(AppColors.DividerColor),
        width: Constants.DividerWidth,
      ))),
      child: Row(
        children: <Widget>[_avatarIcon, SizedBox(width: 12.0), Text(title)],
      ),
    ));

    // 分组标签
    Widget _itemBody;
    if (this.groupTitle != null) {
      _itemBody = Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
            alignment: Alignment.centerLeft,
            color: Color(AppColors.ContactGroupTitleBg),
            child:
                Text(this.groupTitle, style: AppStyles.GroupTitleItemTextStyle),
          ),
          _button
        ],
      );
    } else {
      _itemBody = _button;
    }

    return _itemBody;
  }
}

class ContactsPage extends StatefulWidget {
  Color _indexBarBg = Colors.transparent;
  String _currentLetter = '';

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

const INDEX_BAR_WORDS = [
  "↑",
  "☆",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
];

class _ContactsPageState extends State<ContactsPage> {
  ScrollController _scrollController;
  final ContactsPageData data = ContactsPageData.mock();
  final List<Contact> _contacts = [];
  final Map _lettersPosMap = {INDEX_BAR_WORDS[0]: 0.0};

  final List<_ContactItem> _functionButtons = [
    _ContactItem(
      avatar: 'assets/images/ic_new_friend.png',
      title: '新的朋友',
      onPressed: () {
        print('onclick 新的朋友');
      },
    ),
    _ContactItem(
      avatar: 'assets/images/ic_group_chat.png',
      title: '群聊',
      onPressed: () {
        print('onclick 群聊');
      },
    ),
    _ContactItem(
      avatar: 'assets/images/ic_tag.png',
      title: '标签',
      onPressed: () {
        print('onclick 标签');
      },
    ),
    _ContactItem(
      avatar: 'assets/images/ic_public_account.png',
      title: '公众号',
      onPressed: () {
        print('onclick 公众号');
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    _contacts
      ..addAll(data.contacts)
      ..addAll(data.contacts)
      ..addAll(data.contacts);
    _contacts
        .sort((Contact a, Contact b) => a.nameIndex.compareTo(b.nameIndex));
    _scrollController = new ScrollController();

    var _totalPos = _functionButtons.length * _ContactItem._height(false);
    for (int i = 0; i < _contacts.length; i++) {
      bool _hasGroupTitle = true;
      if (i > 0 && _contacts[i].nameIndex == _contacts[i - 1].nameIndex) {
        _hasGroupTitle = false;
      }
      if (_hasGroupTitle) {
        _lettersPosMap[_contacts[i].nameIndex] = _totalPos;
      }
      _totalPos += _ContactItem._height(_hasGroupTitle);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _getLetter(BuildContext context, double tileHeight, Offset globalPos) {
    RenderBox _box = context.findRenderObject();
    var local = _box.globalToLocal(globalPos);
    int index = (local.dy ~/ tileHeight).clamp(0, INDEX_BAR_WORDS.length - 1);
    return INDEX_BAR_WORDS[index];
  }

  void _jumpToIndex(String letter) {
    if (_lettersPosMap.isNotEmpty) {
      final _pos = _lettersPosMap[letter];
      if (_pos != null) {
        _scrollController.animateTo(_pos,
            duration: Duration(milliseconds: 200), curve: Curves.easeOut);
      }
    }
  }

  Widget _buildIndexBar(BuildContext context, BoxConstraints constraints) {
    final List<Widget> _letters = INDEX_BAR_WORDS.map((String word) {
      return Expanded(
        child: Text(word),
      );
    }).toList();

    final _totalHeight = constraints.biggest.height;
    final _tileHeight = _totalHeight / _letters.length;

    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        setState(() {
          widget._indexBarBg = Colors.black26;
          widget._currentLetter =
              _getLetter(context, _tileHeight, details.globalPosition);
          _jumpToIndex(widget._currentLetter);
        });
      },
      onVerticalDragEnd: (DragEndDetails details) {
        setState(() {
          widget._indexBarBg = Colors.transparent;
          widget._currentLetter = null;
        });
      },
      onVerticalDragCancel: () {
        setState(() {
          widget._indexBarBg = Colors.transparent;
          widget._currentLetter = null;
        });
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          widget._currentLetter =
              _getLetter(context, _tileHeight, details.globalPosition);
          _jumpToIndex(widget._currentLetter);
        });
      },
      child: Column(
        children: _letters,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _body = [
      ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index < 4) {
            return _functionButtons[index];
          }
          int _contactIndex = index - 4;
          Contact _contact = _contacts[index - 4];

          bool _isGroupTitel = true;
          if (_contactIndex >= 1 &&
              _contact.nameIndex == _contacts[_contactIndex - 1].nameIndex) {
            _isGroupTitel = false;
          }
          return _ContactItem(
              avatar: _contact.avatar,
              title: _contact.name,
              groupTitle: _isGroupTitel ? _contact.nameIndex : null);
        },
        itemCount: _contacts.length + 4,
        controller: _scrollController,
      ),
      Positioned(
          width: Constants.IndexBarWidth,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: Container(
              color: widget._indexBarBg,
              child: LayoutBuilder(
                builder: _buildIndexBar,
              ))),
    ];
    if (widget._currentLetter != null && widget._currentLetter.isNotEmpty) {
      _body.add(Center(
        child: Container(
          width: Constants.IndexLetterBoxSize,
          height: Constants.IndexLetterBoxSize,
          decoration: BoxDecoration(
              color: AppColors.IndexLetterBoxBg,
              borderRadius: BorderRadius.all(
                  Radius.circular(Constants.IndexLetterBoxRadius))),
          child: Center(
            child: Text(widget._currentLetter,
                style: AppStyles.IndexLetterBoxTextStyle),
          ),
        ),
      ));
    }
    return Stack(
      children: _body
    );
  }
}
