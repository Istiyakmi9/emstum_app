import 'package:bot_org_manage/screens/home_layout/home_controller.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageAppBar extends GetView<HomeController> {
  const PageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            child: const Text('AH'),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${controller.user!.FirstName} ${controller.user!.LastName}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Stack(
            children: [
              Icon(
                Icons.notifications_none,
                color: Theme.of(context).colorScheme.surface,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 15,
                  height: 12,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "1",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Navigate.login, (route) => false);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.power_settings_new_outlined,
            color: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Navigate.login, (route) => false);
          },
        )
      ],
    );
  }
}
