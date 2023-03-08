// import 'package:shared_preferences/shared_preferences.dart';

// class Prefs {
//   static late SharedPreferences _prefs;

  

//   static Future<SharedPreferences> init() async {
//     _prefs = await SharedPreferences.getInstance();
//     return _prefs;
//   }

//   static Future<bool> setString(String key, String value) async =>
//       await _prefs.setString(key, value);

//   static String getString(String key, void addToDoItem) => _prefs.getString(key).toString();

//   static Future<bool> remove(String key) async => await _prefs.remove(key);
// }