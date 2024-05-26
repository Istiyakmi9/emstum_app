import 'package:bot_org_manage/screens/login/login_controller.dart';
import 'package:bot_org_manage/screens/login/widgets/login_index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modal/Configuration.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : LoginIndex(),
    );
  }
}
