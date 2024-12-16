import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  Future<void> setItem(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonValue = json.encode(value);
    await prefs.setString(key, jsonValue);
  }

  Future<dynamic> getItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonValue = prefs.getString(key);
    return jsonValue != null ? json.decode(jsonValue) : null;
  }
}
