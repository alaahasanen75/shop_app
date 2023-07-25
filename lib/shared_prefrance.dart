import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedpreferences;
  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> PutData({bool? value, String? key}) async {
    return await sharedpreferences?.setBool(key!, value!);
  }

  static dynamic getData({String? key}) {
    return sharedpreferences?.get(key!);
  }

  static Future<bool?> SaveData(
      {required dynamic value, required String? key}) async {
    if (value is bool) return await sharedpreferences?.setBool(key!, value);
    if (value is int) return await sharedpreferences?.setInt(key!, value);
    if (value is String) return await sharedpreferences?.setString(key!, value);
    return await sharedpreferences?.setDouble(key!, value!);
  }

  static Future<bool?> removeData({required String? key}) async {
    return await sharedpreferences?.remove(key!);
  }
}
