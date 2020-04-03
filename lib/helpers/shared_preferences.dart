import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class FlutterSharedPreferences {
  static const String package_name = "kuzzleflutteradmin";
  static FlutterSharedPreferences _instance;

  static FlutterSharedPreferences getInstance() {
    if (_instance == null) {
      _instance = FlutterSharedPreferences();
    }
    return _instance;
  }

  SharedPreferences _sharedPreferences;

  FlutterSharedPreferences() {
    this._init();
  }

  bool get _isMobile {
    return Platform.isAndroid || Platform.isIOS;
  }

  String _prefsPath(String key) {
    if (Platform.isWindows) {
      if (Platform.environment.containsKey("HOMEDRIVE") &&
          Platform.environment.containsKey("HOMEPATH")) {
        var homeDrive = Platform.environment["HOMEDRIVE"];
        var homePath = Platform.environment["HOMEPATH"];
        return "$homeDrive$homePath\\.config\\${FlutterSharedPreferences.package_name}\\$key";
      }
    } else if (Platform.isLinux || Platform.isMacOS) {
      return "%HOME";
    }
    return null;
  }

  Future<void> _init() async {
    if (_isMobile) {
      if (_sharedPreferences == null) {
        _sharedPreferences = await SharedPreferences.getInstance();
      }
    }
  }

  Future<Map<String, dynamic>> getJson(String key) async {
    try {
      var jsonStr = await getString(key);
      Map<String, dynamic> json = jsonDecode(jsonStr);
      return json;
    } catch (e) {
      return null;
    }
  }

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    await this._init();
    try {
      String jsonStr = jsonEncode(value);
      await setString(key, jsonStr);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getString(String key) async {
    await this._init();
    if (_isMobile) {
      try {
        String jsonStr = _sharedPreferences.getString(key);
        return jsonStr;
      } catch (e) {
        return null;
      }
    } else {
      String filePath = _prefsPath(key);
      var file = File(filePath);
      if (file.existsSync()) {
        return file.readAsStringSync();
      } else {
        return null;
      }
    }
  }

  Future<void> setString(String key, String value) async {
    await this._init();
    try {
      if (_isMobile) {
        return await _sharedPreferences.setString(key, value);
      } else {
        String filePath = _prefsPath(key);
        var file = File(filePath);
        file.createSync(recursive: true);
        return await file.writeAsString(value);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> clear(String key) async {
    if (_isMobile) {
      return await _sharedPreferences.remove(key);
    } else {
      String filePath = _prefsPath(key);
      var file = File(filePath);
      return await file.delete(recursive: true);
    }
  }

  Future<void> clearAll() async {
    if (_isMobile) {
      return await _sharedPreferences.clear();
    } else {
      String filePath = _prefsPath("");
      var file = File(filePath);
      return await file.delete(recursive: true);
    }
  }
}
