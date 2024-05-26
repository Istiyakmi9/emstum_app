import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/screens/dashboard/dashboard_controller.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutPopup extends StatefulWidget {
  const LogoutPopup({super.key});

  @override
  State<LogoutPopup> createState() => _LogoutPopupState();
}

class _LogoutPopupState extends State<LogoutPopup> {
  bool _isLoggingOut = false;
  var controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("Do you want to logout !!!"),
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            const Text("Do you ready want to logout?"),
            const SizedBox(
              height: 60,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "User: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: controller.user!.Email,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text("If yes, then please press the Logout button."),
            const SizedBox(
              height: 60,
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Note: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                        "On logout we will delete all your stuff from your device",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              // your code
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
            child: const Text("Cancel")),
        ElevatedButton(
          child: _isLoggingOut
              ? const Text("Wait ...")
              : const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
          onPressed: () {
            // _ajax.get("user/delete/${_user!.Email}").then((value) {
            // });

            setState(() {
              _isLoggingOut = true;
            });

            Util.cleanAll();
            Get.offAllNamed(Navigate.login);
          },
        )
      ],
    );
    ;
  }
}
