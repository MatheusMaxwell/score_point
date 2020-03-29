import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:score_point/model/Player.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "/ScorePoint.db";
  static final _databaseVersion = 1;
  static final table = 'player';
  static final columnId = 'id';
  static final columnNome = 'name';
  static final columnScore = 'score';
  static final columnScoreLoser = 'score_loser';
  static final columnIsLost = 'is_lost';

  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + _databaseName;
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Player(id INTEGER PRIMARY KEY, name TEXT, score INTEGER, score_loser INTEGER, is_lost INTEGER)");
  }


  Future<int> savePlayer(Player player) async {
    var dbClient = await db;
    int res = await dbClient.insert("Player", player.toMap());
    return res;
  }

  Future<List<Player>> getPlayers() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Player');
    List<Player> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var player =
      new Player(list[i]["name"], list[i]["score"], list[i]["score_loser"], list[i]["is_lost"]);
      player.setUserId(list[i]["id"]);
      employees.add(player);
    }
    print(employees.length);
    return employees;
  }

  Future<int> deletePlayer(Player player) async {
    var dbClient = await db;

    int res =
    await dbClient.rawDelete('DELETE FROM Player WHERE id = ?', [player.id]);
    return res;
  }

  Future<bool> updatePlayer(Player player) async {
    var dbClient = await db;
    int res =   await dbClient.update("Player", player.toMap(),
        where: "id = ?", whereArgs: <int>[player.id]);
    return res > 0 ? true : false;
  }

  Future<int> clearData()async{
    var dbClient = await db;
    int res = await dbClient.rawDelete('DELETE FROM Player');
    return res;
  }
}