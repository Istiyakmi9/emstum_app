import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();
  var code = TextEditingController();
  User user = User();
  var util = Util.util;
  Ajax ajax = Ajax.getInstance();
  var isSubmitted = false.obs;
  SharedPreferences? _preferences;
  var isLoading = false.obs;

  updateSubmit(bool flag) {
    isSubmitted(flag);
  }

  updateLoading(bool flag) {
    isSubmitted(flag);
  }

  void onSubmitted() {
    formKey.currentState?.save();
    ajax.login("auth/Login/Authenticate", {
      "Mobile": "",
      "EmailId": username.text,
      "Password": password.text,
      "CompanyCode": code.text
    }).then((value) {
      Fluttertoast.showToast(msg: "Login successfully.");
      var result = Ajax.getResponseResult(value);
      user = User.fromJson(result["UserDetail"]);
      util.setUserDetail(result);

      Get.offAllNamed("/home");
    }).catchError((e) {
      updateSubmit(false);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    username.text = "hr@bottomhalf.in";
    password.text = "welcome@\$Bot_001";
    code.text = "BOT00004";
  }
}