
class Player {
  int id;
  String _name;
  int _score;
  int _scoreLoser;
  int _isLost;
  //int _scoreTotal;

  Player(this._name, this._score, this._scoreLoser, this._isLost);

  Player.map(dynamic obj) {
    this._name = obj["name"];
    this._score = obj["score"];
    this._scoreLoser = obj["score_loser"];
    this._isLost = obj["is_lost"];
    //this._scoreTotal = obj["score_total"];
  }

  String get name => _name;

  int get score => _score;
  set score(int number) => _score = number;

  int get scoreLoser => _scoreLoser;
  set scoreLoser(int number) => _scoreLoser = number;

  bool get isLost => (_isLost == 1) ? true : false;
  set isLost(bool lost) => (lost) ? _isLost = 1 : _isLost = 0;

  /*int get scoreTotal => _scoreTotal;
  set scoreTotal(int number) => _scoreTotal = number;*/


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["score"] = _score;
    map["score_loser"] = _scoreLoser;
    map["is_lost"] = _isLost;
    //map["score_total"] = _scoreTotal;
    return map;
  }
  void setUserId(int id) {
    this.id = id;
  }

}