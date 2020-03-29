import 'package:flutter/material.dart';
import 'package:score_point/ext/Components.dart';
import 'package:score_point/ext/Constants.dart';
import 'package:score_point/ext/MyColors.dart';
import 'package:score_point/ext/MyTextStyle.dart';
import 'package:score_point/model/Player.dart';
import 'package:score_point/pages/new_game/new_game_presenter.dart';
import 'package:score_point/utils/ApplicationSingleton.dart';
import 'package:score_point/utils/MyMediaQuery.dart';
import 'package:score_point/utils/Widgets.dart';

class NewGame extends StatefulWidget {
  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> implements NewGameContract {

  NewGamePresenter presenter;
  final dbHelper = ApplicationSingleton.dbHelper;
  bool listEmpty = false;
  List<Player> players = new List<Player>();
  bool refreshing = true;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  int countWinner = 0;
  String playerWinner;

  _NewGameState(){
    presenter = NewGamePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    presenter.getPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: MyColors.primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          Player player = await _dialogNewPlayer();
          if(player != null){
            presenter.insert(player);
          }
        },
        backgroundColor: MyColors.secondColor,
        child: Icon(Icons.add, color: MyColors.primaryColor,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            spaceVert(20),
            Image.asset("assets/images/players.png"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.exit_to_app, color: MyColors.secondColor,),
                  onPressed: ()async {
                    bool ret = await _dialogEndGame();
                    if (ret) {
                      await presenter.endGame();
                    }
                  }
                ),
              ],
            ),
            _body()
          ],
        ),
      ),
    );
  }

  _endGame()async {
    bool ret = await _dialogEndGame();
    if (ret) {
      await presenter.endGame();
    }
  }

  _body(){
    if(listEmpty != null && listEmpty){
      return emptyContainer('Insira novos jogadores');
    }
    else{
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: (players != null) ? players.length : 0,
                      itemBuilder: (BuildContext context, int index){
                        Color colorCard = (players[index].score < 0) ? Colors.red : Colors.white;
                        Color colorScore = (players[index].scoreLoser > 0) ? Colors.red : Colors.green;
                        String scoreLoser = "-"+players[index].scoreLoser.toString();
                        _verifyPlayerLoser(index);
                        return cardTitleSubtitle(players[index].name, players[index].score.toString(), scoreLoser, colorCard, colorScore);
                      },
                    ),
                    buttonGreenTextPrimary("Fim do Turno", _endShift),
                  ],
                ),
              ),
              refreshing ? circleProgress() : SizedBox()
            ],
          ),
        ),
      );
    }
  }


  _endShift(){
    ApplicationSingleton.players = players;
    Navigator.of(context).pushReplacementNamed(Constants.END_SHIFT);
  }

  _verifyPlayerLoser(int index)async{
    Future.delayed(Duration(seconds: 2)).then((_)async {
      if(players[index].score < 0 && !players[index].isLost){
        players[index].isLost = true;
        presenter.update(players[index]);
        await _showDialogLoserWinner(players[index].name, true);
      }

    });
  }

  _showDialogLoserWinner(String name, bool isLoser){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          ),
          backgroundColor: MyColors.primaryColorDark,
          contentPadding: EdgeInsets.all(0.0),
          content: Container(
            width: MyMediaQuery.size.width*0.9,
            height: MyMediaQuery.size.height*0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: <Widget>[
                      Center(child: Text((isLoser)? "$name perdeu!" : "$name ganhou!" , style: MyTextStyle.ultraBigWhiteBold,)),
                      isLoser ? SizedBox() : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("assets/images/confetti.gif", height: MyMediaQuery.size.height*0.10,),
                          Image.asset("assets/images/confetti.gif", height: MyMediaQuery.size.height*0.10,),
                          Image.asset("assets/images/confetti.gif", height: MyMediaQuery.size.height*0.10,),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(15.0),
                      bottomRight: const Radius.circular(15.0),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text('Ok', style: MyTextStyle.bigWhiteBold,),
                      onPressed: () {
                        if(!isLoser) {
                          Future.delayed(Duration(seconds: 1)).then((_) {
                            _endGame();
                          });
                        }
                        else{
                          Future.delayed(Duration(seconds: 1)).then((_) {
                            _verifyPlayerWinner();
                          });
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _verifyPlayerWinner()async{
    if(countWinner != -1){
      for(var player in players){
        if(!player.isLost){
          countWinner ++;
          playerWinner = player.name;
        }
      }
      if(countWinner == 1 && players.length > 1){
        countWinner = -1;
        await _showDialogLoserWinner(playerWinner, false);
      }
    }
  }

  Future<bool> _dialogEndGame(){
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Terminar Jogo"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          ),
          content: Text("Terminar o jogo?", style: MyTextStyle.bigBlack,),
          actions: <Widget>[
            FlatButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<Player> _dialogNewPlayer(){
    String name;
    int score;
    Player player;
    final TextEditingController controllerName = new TextEditingController();
    final TextEditingController controllerScore = new TextEditingController();
    controllerScore.text = "100";
    return showDialog<Player>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Novo Jogador"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: new InputDecoration(
                    hintText: 'Nome'
                ),
                onChanged: (value) {
                  name = value;
                },
                controller: controllerName,
                autofocus: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 40,
                    child: TextField(
                      onChanged: (value) {
                        score = int.parse(value);
                      },
                      controller: controllerScore,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    width: 80,
                      child: Text("Pontos", style: MyTextStyle.mediumBlack,)
                  )
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                name = controllerName.text;
                score = int.parse(controllerScore.text);
                player = new Player(name, score, 0, 0);
                Navigator.of(context).pop(player);
              },
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(player);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void getSuccess(List<Player> list) {
    setState(() {
      players = list;
      listEmpty = false;
      refreshing = false;
    });
  }

  @override
  void listIsEmpty() {
    setState(() {
      players = List<Player>();
      listEmpty = true;
      refreshing = false;
    });
  }

  @override
  void onError() {
    setState(() {
      refreshing = false;
    });
    //zshowSnackBar("Algo deu errado. Tente novamente.", scaffoldKey);
  }

  @override
  void saveFailed() {
    setState(() {
      refreshing = false;
    });
    showSnackBar("Algo deu errado. Tente novamente.", scaffoldKey);
  }

  @override
  void saveSuccess() async{
    setState(() {
      refreshing = false;
    });
    await presenter.getPlayers();
  }

  @override
  void endGameSuccess() {
    ApplicationSingleton.label = "Novo Jogo";
    Navigator.of(context).pushReplacementNamed(Constants.HOME_PAGE);
  }
}
