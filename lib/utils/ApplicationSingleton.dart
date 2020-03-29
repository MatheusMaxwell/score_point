
import 'package:score_point/data/DatabaseHelper.dart';
import 'package:score_point/model/Player.dart';

class ApplicationSingleton {
  static ApplicationSingleton _instance;
  factory ApplicationSingleton() {
    _instance ??= ApplicationSingleton._internalConstructor();
    return _instance;
  }
  ApplicationSingleton._internalConstructor();

  static DatabaseHelper dbHelper;
  static List<Player> players;
  static String label;
  static bool activeSound;


}