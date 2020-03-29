import 'package:flutter/material.dart';
import 'package:score_point/ext/FontSize.dart';
import 'package:score_point/ext/MyColors.dart';
import 'package:score_point/ext/MyTextStyle.dart';
import 'package:score_point/utils/MyMediaQuery.dart';

buttonWhiteTextPrimary(String text, Function onPressed){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      RaisedButton(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(text, style: MyTextStyle.bigPrimaryBold,),
        ),
      ),
    ],
  );
}

buttonGreenTextPrimary(String text, Function onPressed){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      RaisedButton(
        color: MyColors.primaryColorDark,
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(text, style: MyTextStyle.bigWhiteBold,),
        ),
      ),
    ],
  );
}

Widget spaceVert(double space){
  return SizedBox(
    height: space,
  );
}

Widget emptyContainer(String text){
  return Container(
      color: MyColors.primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            spaceVert(100),
            Container(
              child: Icon(Icons.person_add, size: 200, color: Colors.white70,),
            ),
            Text(text, style: MyTextStyle.mediumWhite,)
          ],
        ),
      )
  );
}

Widget circleProgress(){
  return Container(
    color: Colors.white30,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget cardTitleSubtitle(String title, String subtitle, String score, Color color, Color scoreColor) {
  return Card(
    color: color,
    elevation: 5,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
    ),
    child: Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: MyTextStyle.bigBlack,),
              Text(subtitle, style: MyTextStyle.mediumGrey,),
            ],
          ),
          Text(score, style: TextStyle(fontSize: FontSize.medium, color: scoreColor))
        ],
      ),
    ),
  );
}
