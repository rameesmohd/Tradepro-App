import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static const String userTokenKey = "user_token_key";

  static Future<void> setData<T>(String key, T data) async {
    final prefs = await SharedPreferences.getInstance();

    if (data is String) {
      await prefs.setString(key, data);
    } else if (data is bool) {
      await prefs.setBool(key, data);
    } else if (data is int) {
      await prefs.setInt(key, data);
    } else if (data is double) {
      await prefs.setDouble(key, data);
    } else if (data is List<String>) {
      await prefs.setStringList(key, data);
    } else {
      throw Exception("Unsupported data type");
    }
  }

  static Future<T?> getData<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else {
      throw Exception("Unsupported data type");
    }
  }

  static Future<bool> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}