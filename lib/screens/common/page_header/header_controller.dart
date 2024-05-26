import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:get/get.dart';

class HeaderController extends GetxController {
  final Util util = Util();
  User? user;
  bool isLoggingOut = false;
  NavigationParams? arg;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = util.getUserDetail();
  }
}