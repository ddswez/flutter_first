import 'package:flutter/material.dart'; //1
import './home/home_screen.dart';
import './home/constants.dart' show AppColors;

void main() => runApp(MaterialApp(
  title: 'wechat',
  theme: ThemeData.light().copyWith(
    primaryColor: Color(AppColors.AppBarColor),
    cardColor: Color(AppColors.CardBgColor),
  ),
  home: HomeScreen(),
  debugShowCheckedModeBanner: false,
)); //2


