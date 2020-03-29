import 'package:flutter/material.dart';
import 'package:score_point/ext/Constants.dart';
import 'package:score_point/ext/MyColors.dart';
import 'package:score_point/model/Player.dart';
import 'package:score_point/utils/ApplicationSingleton.dart';
import 'package:score_point/utils/Widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String label = ApplicationSingleton.label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            spaceVert(140),
            Image.asset("assets/images/logo_title.png"),
            spaceVert(80),
            buttonWhiteTextPrimary(label,_newGame),
            //spaceVert(20),
            //buttonWhiteTextPrimary("Ranking",  _ranking),
            spaceVert(30),
            buttonWhiteTextPrimary("Configurações", _settings)
          ],
        ),
      ),
    );
  }

  _newGame(){
    Navigator.of(context).pushReplacementNamed(Constants.NEW_GAME);
  }

  _settings(){
    Navigator.of(context).pushReplacementNamed(Constants.SETTINGS_PAGE);
  }
}
