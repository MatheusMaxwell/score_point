
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_point/ext/FontSize.dart';
import 'package:score_point/ext/MyColors.dart';

class MyTextStyle {

  static var smallBlack = TextStyle(fontSize: FontSize.small, color: MyColors.primaryFont);
  static var smallBoldBlack = TextStyle(fontSize: FontSize.small, fontWeight: FontWeight.bold, color: MyColors.primaryFont);
  static var smallWhite = TextStyle(fontSize: FontSize.small, color: MyColors.secondFont);
  static var smallBoldWhite = TextStyle(fontSize: FontSize.small, color: MyColors.secondFont);
  static var smallGray = TextStyle(color: Colors.grey, fontSize: FontSize.small);
  static var smallPrimaryColor = TextStyle(fontSize: FontSize.small, color: MyColors.primaryColor);

  static var mediumBlack = TextStyle(fontSize: FontSize.medium, color: MyColors.primaryFont);
  static var mediumWhite = TextStyle(fontSize: FontSize.medium, color: MyColors.secondFont);
  static var mediumGrey = TextStyle(fontSize: FontSize.medium, color: Colors.grey);

  static var bigWhiteBold = TextStyle(fontSize: FontSize.big, color: MyColors.secondFont, fontWeight: FontWeight.bold);
  static var bigPrimaryBold = TextStyle(fontSize: FontSize.big, color: MyColors.primaryColor, fontWeight: FontWeight.bold);
  static var bigBlack = TextStyle(fontSize: FontSize.big, color: MyColors.primaryFont);

  static var ultraBigWhiteBold = TextStyle(fontSize: FontSize.ultraBig, color: MyColors.secondFont, fontWeight: FontWeight.bold);


}