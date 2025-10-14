import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

/// Singleton class for managing SharedPreferences
/// Located in core/utils as it's shared across all features
class PrefHelper {
  static PrefHelper? _instance;
  static SharedPreferences? _preferences;

  // Private constructor
  PrefHelper._();

  /// Get singleton instance
  static PrefHelper get instance {
    _instance ??= PrefHelper._();
    return _instance!;
  }

  /// Initialize SharedPreferences
  /// Call this in main() before runApp()
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // String operations
  Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  String getString(String key, {String defaultValue = ''}) {
    return _preferences!.getString(key) ?? defaultValue;
  }

  // Int operations
  Future<bool> setInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _preferences!.getInt(key) ?? defaultValue;
  }

  // Bool operations
  Future<bool> setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences!.getBool(key) ?? defaultValue;
  }

  // Double operations
  Future<bool> setDouble(String key, double value) async {
    return await _preferences!.setDouble(key, value);
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _preferences!.getDouble(key) ?? defaultValue;
  }

  // List<String> operations
  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences!.setStringList(key, value);
  }

  List<String> getStringList(String key, {List<String>? defaultValue}) {
    return _preferences!.getStringList(key) ?? defaultValue ?? [];
  }

  // Remove a key
  Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }

  // Clear all preferences
  Future<bool> clear() async {
    return await _preferences!.clear();
  }

  // Check if key exists
  bool containsKey(String key) {
    return _preferences!.containsKey(key);
  }

  // Get all keys
  Set<String> getKeys() {
    return _preferences!.getKeys();
  }

  // Custom method for language (example)
  int getLanguage() {
    return getInt(
      AppConstants.language.key,
      defaultValue: 1,
    ); // 1 for English, 2 for Bengali
  }

  Future<bool> setLanguage(int language) async {
    return await setInt(AppConstants.language.key, language);
  }
}

