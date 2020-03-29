import 'package:flutter/material.dart';
import 'package:score_point/ext/Components.dart';
import 'package:score_point/ext/Constants.dart';
import 'package:score_point/ext/MyColors.dart';
import 'package:score_point/ext/MyTextStyle.dart';
import 'package:score_point/model/Player.dart';
import 'package:score_point/pages/end_shift/end_shift_presenter.dart';
import 'package:score_point/utils/ApplicationSingleton.dart';
import 'package:score_point/utils/Widgets.dart';

class EndShift extends StatefulWidget {
  @override
  _EndShiftState createState() => _EndShiftState();
}

class _EndShiftState extends State<EndShift> implements EndShiftContract{
  List<Player> players = ApplicationSingleton.players;
  EndShiftPresenter presenter;
  final containerKey = new GlobalKey();
  bool refreshing = false;
  _EndShiftState(){
    presenter = EndShiftPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            key: containerKey,
            color: MyColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      spaceVert(40),
                      Image.asset("assets/images/end_shift.png"),
                      spaceVert(20),
                      Text("Quanto cada jogador perdeu?", style: MyTextStyle.bigWhiteBold,),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: (players != null) ? players.length : 0,
                        itemBuilder: (BuildContext context, int index){
                          return _card(index);
                        },
                      ),
                    ],
                  ),
                  buttonGreenTextPrimary("Confirmar", _btnConfirm),
                ],
              ),
            ),
          ),
        ),
        refreshing ? circleProgress() : SizedBox()
      ],
    );
  }

  _btnConfirm()async{
    setState(() {
      refreshing = true;
    });
    for(var player in players){
      player.score = player.score - player.scoreLoser;
      await presenter.update(player);
    }
    Future.delayed(Duration(seconds: 1)).then((_) {
      Navigator.of(context).pushReplacementNamed(Constants.NEW_GAME);
    });

  }

  _card(int index){
    final TextEditingController controller = new TextEditingController();
    players[index].scoreLoser = 0;
    controller.text = players[index].scoreLoser.toString();
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child:
                Text(players[index].name, style: MyTextStyle.bigBlack,),
            ),
            Container(
              width: 40,
              child: TextField(
                onChanged: (value) {
                  players[index].scoreLoser = int.parse(value);
                },
                controller: controller,
                autofocus: true,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void updateFailed() {
    setState(() {
      refreshing = false;
    });
    showSnackBar("Algo deu errado. Tente novamente.", containerKey);
  }

}
