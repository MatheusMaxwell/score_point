
import 'package:flutter/material.dart';
import 'package:score_point/ext/Constants.dart';
import 'package:score_point/ext/MyTextStyle.dart';
import 'package:score_point/utils/ApplicationSingleton.dart';
import 'package:score_point/utils/MySharedPreferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _switchValue;

  @override
  void initState() {
    super.initState();
    _switchValue = ApplicationSingleton.activeSound;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _lineActiveSound()
      ],
    );
  }

  _lineActiveSound(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Text(
            "Habilitar som", style: MyTextStyle.mediumBlack,
          ),
          Switch(
            value: _switchValue,
            onChanged: (value){
              _switchValue = value;
              ApplicationSingleton.activeSound = _switchValue;
              MySharedPreferences.saveBoolean(_switchValue, Constants.SHARED_PREF_SOUND);
            },
          )
        ],
      ),
    );
  }

}
