import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'storage.dart';

class SharedPreferencesStore extends Storage {
  @override
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return json.decode(prefs.getString(key)!);
    } catch (e) {
      return null;
    }
  }

  @override
  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  @override
  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
