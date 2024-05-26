import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/employee_quickview.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final Util util = Util();
  User? user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = util.getUserDetail();
  }
}
