import 'package:flutter/material.dart';

class Profile {
  final String name;
  final String avatar;
  final String account;

  const Profile(
      {@required this.name, @required this.avatar, @required this.account});
}

const Profile me = Profile(
  name: 'justYuMu',
  avatar: 'https://randomuser.me/api/portraits/women/17.jpg',
  account: 'test_account'
);
