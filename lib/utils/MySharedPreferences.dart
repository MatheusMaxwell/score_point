
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{

  static saveBoolean(bool data, String key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, data);
  }

  static Future<bool> getBoolean(String key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

}