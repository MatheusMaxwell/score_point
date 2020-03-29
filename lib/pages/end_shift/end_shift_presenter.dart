
import 'package:score_point/model/Player.dart';
import 'package:score_point/utils/ApplicationSingleton.dart';

abstract class EndShiftContract{
  void updateFailed();
}

class EndShiftPresenter {
  EndShiftContract _view;
  var db = ApplicationSingleton.dbHelper;
  EndShiftPresenter(this._view);

  Future<bool> update(Player player)async{
    bool ret = false;
    try{
      ret = await db.updatePlayer(player);
      return ret;
    }catch(e){
      _view.updateFailed();
      return ret;
    }
  }
}