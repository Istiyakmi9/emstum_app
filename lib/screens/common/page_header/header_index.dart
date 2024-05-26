import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/logout_popup.dart';
import 'package:flutter/material.dart';

class HeaderIndex extends StatelessWidget {
  final bool isChildPage;

  const HeaderIndex({super.key, this.isChildPage = true});

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isChildPage
                  ? InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                    ),
              Text(
                "Page Name",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              InkWell(
                onTap: () {
                  showPopup(context);
                },
                child: const Icon(
                  Icons.power_settings_new_outlined,
                  color: Colors.grey,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
