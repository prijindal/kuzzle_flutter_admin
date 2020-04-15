import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class FlutterSharedPreferences {
  FlutterSharedPreferences() {
    this._init();
  }

  static const String package_name = 'kuzzleflutteradmin';
  static FlutterSharedPreferences _instance;

  static FlutterSharedPreferences getInstance() =>
      _instance ??= FlutterSharedPreferences();

  SharedPreferences _sharedPreferences;

  bool get _isMobile => Platform.isAndroid || Platform.isIOS;

  String _prefsPath(String key) {
    if (Platform.isWindows) {
      if (Platform.environment.containsKey('HOMEDRIVE') &&
          Platform.environment.containsKey('HOMEPATH')) {
        final homeDrive = Platform.environment['HOMEDRIVE'];
        final homePath = Platform.environment['HOMEPATH'];
        return '$homeDrive$homePath\\.config\\${FlutterSharedPreferences.package_name}\\$key';
      }
    } else if (Platform.isLinux || Platform.isMacOS) {
      return '%HOME';
    }
    return null;
  }

  Future<void> _init() async {
    if (_isMobile) {
      _sharedPreferences ??= await SharedPreferences.getInstance();
    }
  }

  Future<Map<String, dynamic>> getJson(String key) async {
    try {
      final jsonStr = await getString(key);
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      return json;
    } catch (e) {
      return null;
    }
  }

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    await this._init();
    try {
      final jsonStr = jsonEncode(value);
      await setString(key, jsonStr);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getString(String key) async {
    await this._init();
    if (_isMobile) {
      try {
        final str = _sharedPreferences.getString(key);
        return str;
      } catch (e) {
        return null;
      }
    } else {
      final filePath = _prefsPath(key);
      final file = File(filePath);
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
        final filePath = _prefsPath(key);
        final file = File(filePath);
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
      final filePath = _prefsPath(key);
      final file = File(filePath);
      return await file.delete(recursive: true);
    }
  }

  Future<void> clearAll() async {
    if (_isMobile) {
      return await _sharedPreferences.clear();
    } else {
      final filePath = _prefsPath('');
      final file = File(filePath);
      return await file.delete(recursive: true);
    }
  }
}
