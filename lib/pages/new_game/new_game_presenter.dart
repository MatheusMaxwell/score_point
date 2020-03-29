import 'package:score_point/model/Player.dart';
import 'package:score_point/utils/ApplicationSingleton.dart';

abstract class NewGameContract {
  void saveSuccess();
  void saveFailed();
  void getSuccess(List<Player> list);
  void endGameSuccess();
  void listIsEmpty();
  void onError();
}

class NewGamePresenter {
  NewGameContract _view;
  var db = ApplicationSingleton.dbHelper;
  NewGamePresenter(this._view);

  delete(Player player) {
    db.deletePlayer(player);
  }

  insert(Player player){
    try{
      db.savePlayer(player);
      _view.saveSuccess();
    }catch(e){
      var i = e;
      _view.saveFailed();
    }
  }

  Future<List<Player>> getPlayers() async{
    try{
      List<Player> players = await db.getPlayers();
      if(players.isNotEmpty)
        _view.getSuccess(players);
      else
        _view.listIsEmpty();
    }catch(e){
      var i = e;
      _view.onError();
    }

  }

  update(Player player){
    try{
      db.updatePlayer(player);
    }
    catch(e){
      _view.onError();
    }
  }

  endGame(){
    try{
      db.clearData();
      _view.endGameSuccess();
    }
    catch(e){
      _view.onError();
    }
  }

}