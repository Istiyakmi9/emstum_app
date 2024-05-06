import 'package:bot_org_manage/modal/user.dart';
import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  User user = User();

  void updateUser(User user) {
    this.user = user;
    notifyListeners();
  }
}