import 'package:shared_preferences/shared_preferences.dart';

setPreference(String key, dynamic value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (value.runtimeType) {
    case const (String):
      await prefs.setString(key, value);
      break;
    case const (int):
      await prefs.setInt(key, value);
      break;
    case const (double):
      await prefs.setDouble(key, value);
      break;
    case const (bool):
      await prefs.setBool(key, value);
      break;
    case const (List<String>):
      await prefs.setStringList(key, value);
      break;
    default:
      await prefs.setString(key, value);
      break;
  }
}

getPreference(String key, {String type = 'string'}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic value;
  if (type == 'string') value = prefs.getString(key);
  if (type == 'list') value = prefs.getStringList(key);
  if (type == 'bool') value = prefs.getBool(key);
  return value;
}

deletePreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

cleanPreference(String useCase) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> lstNoRemove = [
  ];

  //for in all prefs keys
  prefs.getKeys().forEach((key) async {
    if (!lstNoRemove.contains(key)) {
      await prefs.remove(key);
    }
  });
}