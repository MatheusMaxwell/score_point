
import 'package:flutter/material.dart';
import 'package:score_point/ext/Constants.dart';

class MyColors {

  static Color primaryColor = Color(getColorFromHex(Constants.PRIMARY_COLOR));
  static Color secondColor = Colors.white;
  static Color primaryFont = Colors.black;
  static Color secondFont = Colors.white;
  static Color primaryColorDark = Color(getColorFromHex("#3CA911"));

  static  MaterialColor primaryColorTheme = MaterialColor (
      getColorFromHex(Constants.PRIMARY_COLOR),
        < int , Color > {
        50 : primaryColor,
        100 : primaryColor,
        200 :  primaryColor,
        300 :  primaryColor,
        400 :  primaryColor,
        500 :  primaryColor,
        600 :  primaryColor,
        700 :  primaryColor,
        800 :  primaryColor,
        900 :  primaryColor,
      }
  );

  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

