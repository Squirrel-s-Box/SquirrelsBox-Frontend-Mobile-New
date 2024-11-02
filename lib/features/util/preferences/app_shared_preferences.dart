import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../management/domain/models/box.dart';

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

cleanPreference({String useCase = ''}) async {
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

/// Manage Last Boxes Used
Future<void> addLastBoxUsed(Box box) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> boxList = prefs.getStringList('boxes_used') ?? [];

  Map<String, dynamic> newMap = box.toMap();
  String newMapString = jsonEncode(newMap);

  boxList.remove(newMapString); // Remove if exist
  boxList.insert(0, newMapString); // Add at the start

  if (boxList.length > 3) {
    boxList = boxList.sublist(0, 3);
  }

  await prefs.setStringList('boxes_used', boxList);
}

Future<List<Box>> getLastBoxesUsed() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> boxList = prefs.getStringList('boxes_used') ?? [];
  return boxList.map((box) {
    return Box.fromMapLocal(jsonDecode(box));
  }).toList();
}

Future<void> deleteBoxUsed(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> boxList = prefs.getStringList('boxes_used') ?? [];
  boxList = boxList.where((jsonStr) {
    Map<String, dynamic> map = jsonDecode(jsonStr);
    return map['id'] != id;
  }).toList();
  await prefs.setStringList('boxes_used', boxList);
}
