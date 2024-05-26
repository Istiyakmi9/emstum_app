import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/screens/leave/leave_controller.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyLeave extends GetView<LeaveController> {
  const ApplyLeave({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("User name"),
          ElevatedButton.icon(
            onPressed: () {
              controller.updateRedirect(true);

              var result =
                  Get.toNamed(Navigate.calendar, arguments: controller.brief);
              if (result != null) {
                controller.calculateAndLoadData(result);
                controller.updateRedirect(false);
              }
            },
            icon: controller.isRedirect.value
                ? SizedBox(
                    width: Configuration.getLoaderSize,
                    height: Configuration.getLoaderSize,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Icon(
                    // <-- Icon
                    Icons.rocket_launch_outlined,
                    size: 24.0,
                  ),
            label: const Text('Apply Now'), // <-- Text
          ),
        ],
      ),
    );
  }
}
