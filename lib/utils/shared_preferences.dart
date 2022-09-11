import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String username = "username";
  static const String password = "password";

  static Future<void> setAccountToSharedPreferences({
    required String username,
    required String password,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(SharedPreferencesHelper.username, username);
    sharedPreferences.setString(SharedPreferencesHelper.password, password);
  }

  static Future<void> clearLoginCredentials() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SharedPreferencesHelper.username, "");
    sharedPreferences.setString(SharedPreferencesHelper.password, "");
  }
}
