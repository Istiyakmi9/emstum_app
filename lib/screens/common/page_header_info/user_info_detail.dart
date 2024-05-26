import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/screens/common/page_header_info/user_info_controller.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/logout_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoDetail extends StatelessWidget {
  final controller = Get.put(UserInfoController());

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Configuration.ColorFromHex("#eeeeec"),
                    foregroundColor: Colors.black,
                    child: const Icon(Icons.person),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Hi! ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  // ignore: unnecessary_null_comparison
                                  "${controller.user!.FirstName} ${controller.user!.LastName}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        controller.user!.Designation != null
                            ? controller.user!.Designation!
                            : 'No Designation defined',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Icon(
              Icons.notifications_rounded,
              color: Colors.deepOrangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}
