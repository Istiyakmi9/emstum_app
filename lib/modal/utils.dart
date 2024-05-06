import 'dart:convert';

import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Util {
  static const UserDetail = "user";

  static final Util util = Util._internal();
  static SharedPreferences? _prefs;

  static Future<void> init(SharedPreferences sharedPreferences) async {
    // ignore: unnecessary_null_comparison
    if (sharedPreferences == null) {
      throw Exception("Invalid Shred Preference object found");
    }

    _prefs = sharedPreferences;
  }

  static SharedPreferences getSharedPreferences() {
    return _prefs!;
  }

  void setUserDetail(dynamic user) {
    String result = jsonEncode(user["UserDetail"]);
    _prefs!.setString(UserDetail, result);
  }

  static void cleanAll() {
    for (String key in _prefs!.getKeys()) {
      debugPrint("Key deleting: $key");
      _prefs!.remove(key);
    }
  }

  User getUserDetail() {
    var user = _prefs!.get(UserDetail) as String;
    dynamic result = jsonDecode(user);
    return User.fromJson(result);
  }

  factory Util() {
    debugPrint("Util constructor called: ${util.hashCode}");
    return util;
  }

  String getStatusName(int id) {
    String name = "Pending";
    switch (id) {
      case 2:
        name = "Pending";
        break;
      case 5:
        name = "Rejected";
        break;
      case 9:
        name = "Approved";
        break;
      case 0:
        name = "Not submitted";
        break;
      case 8:
        name = "Submitted";
        break;
    }

    return name;
  }

  String getStatusColor(int id) {
    String name = Configuration.info;
    switch (id) {
      case 2:
        name = Configuration.deepWarning;
        break;
      case 5:
        name = Configuration.fail;
        break;
      case 9:
        name = Configuration.success;
        break;
      case 0:
      case 8:
        name = Configuration.info;
        break;
    }

    return name;
  }

  Util._internal();
}
