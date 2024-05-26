/*
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/screens/common/page_header_info/user_info_controller.dart';
import 'package:bot_org_manage/screens/common/page_header_info/user_info_detail.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/logout_popup.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../modal/Configuration.dart';
import '../../../modal/user.dart';

class UserInfo extends StatefulWidget {
  NavigationParams? navigationParams;

  UserInfo({Key? key, this.navigationParams = null}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final Util _util = Util();
  User? _user;
  final Ajax _ajax = Ajax.getInstance();
  bool _isLoggingOut = false;
  late NavigationParams _arg;

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutPopup();
      },
    );
  }

  var controller = Get.put(UserInfoController());

  @override
  void initState() {
    super.initState();
    var argument = widget.navigationParams;
    _user = _util.getUserDetail();

    if (argument == null) {
      argument = NavigationParams(isChildPage: false, pageName: "Dashboard");
    } else {
      controller.arg = argument;
    }
  }

  Widget getUserDetailWidget() {
    return Row(
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
                              "${_user!.FirstName} ${_user!.LastName}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _user!.Designation != null
                        ? _user!.Designation!
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserInfoDetail(),
          getUserDetailWidget()
        ],
      ),
    );
  }
}
*/
