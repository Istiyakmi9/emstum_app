import 'package:bot_org_manage/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => Container(
        child: ElevatedButton.icon(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(
                vertical: 10,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.primary,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 0,
                ),
              ),
            ),
          ),
          onPressed: () {
            controller.updateSubmit(true);
            controller.onSubmitted();
          },
          label: !controller.isSubmitted.value
              ? const Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              : const Text(
                  "Please wait...",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
          icon: !controller.isSubmitted.value
              ? const Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                )
              : SizedBox.fromSize(
                  size: const Size(20, 20),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
