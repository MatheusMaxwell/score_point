
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_point/ext/Constants.dart';
import 'package:score_point/ext/MyColors.dart';
import 'package:score_point/ext/MyTextStyle.dart';
import 'package:score_point/model/Player.dart';
import 'package:score_point/utils/ApplicationSingleton.dart';
import 'package:score_point/utils/MyMediaQuery.dart';
import 'package:score_point/utils/MySharedPreferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    MyMediaQuery.mediaQuery = MediaQuery.of(context);
    MyMediaQuery.size = MyMediaQuery.mediaQuery.size;

    return Container(
        color: MyColors.primaryColor,
        width: MyMediaQuery.size.width,
        height: MyMediaQuery.size.height,
        child: Image.asset("assets/images/logo.png")
    );
  }

  @override
  void initState() {
    super.initState();
    _callPage();
  }

  void _callPage()async{
    String label = await _changeLabel();
    if(label.isNotEmpty){
      ApplicationSingleton.label = label;
      ApplicationSingleton.activeSound = await MySharedPreferences.getBoolean(Constants.SHARED_PREF_SOUND);
      ApplicationSingleton.activeSound = ApplicationSingleton.activeSound == null ? false : ApplicationSingleton.activeSound;
      Future.delayed(Duration(seconds: 2)).then((_) {
        Navigator.of(context).pushReplacementNamed(Constants.HOME_PAGE);
      });
    }
  }

  Future<String> _changeLabel()async{
    try{
      List<Player> list = await ApplicationSingleton.dbHelper.getPlayers();
      if(list.isNotEmpty)
        return "Continuar";
      else
        return "Novo Jogo";
    }
    catch(e){
      var i = e;
      return "Novo Jogo";
    }

  }
}