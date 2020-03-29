import 'package:flutter/material.dart';
import 'package:score_point/data/DatabaseHelper.dart';
import 'package:score_point/ext/Constants.dart';
import 'package:score_point/ext/MyColors.dart';
import 'package:score_point/pages/end_shift/end_shift_page.dart';
import 'package:score_point/pages/home_page/home_page.dart';
import 'package:score_point/pages/new_game/new_game_page.dart';
import 'package:score_point/pages/settings_page/settings_page.dart';
import 'package:score_point/pages/splash_screen/splash_screen.dart';
import 'package:score_point/utils/ApplicationSingleton.dart';

void main() => runApp(MyApp());

final routes = {
  Constants.SPLASH_SCREEN: (BuildContext context) => new SplashScreen(),
  Constants.HOME_PAGE: (BuildContext context) => new HomePage(),
  Constants.NEW_GAME: (BuildContext context) => new NewGame(),
  Constants.END_SHIFT: (BuildContext context) => new EndShift(),
  Constants.SETTINGS_PAGE: (BuildContext context) => new SettingsPage()


};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ApplicationSingleton.dbHelper = new DatabaseHelper();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: MyColors.primaryColorTheme),
      routes: routes,
    );
  }
}

