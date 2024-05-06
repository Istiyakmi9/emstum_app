import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
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
        return AlertDialog(
          scrollable: true,
          title: const Text("Do you want to logout !!!"),
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
                        text: _user!.Email,
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
              child:
                  _isLoggingOut ? const Text("Wait ...") : const Text("Logout"),
              onPressed: () {
                // _ajax.get("user/delete/${_user!.Email}").then((value) {
                // });

                setState(() {
                  _isLoggingOut = true;
                });

                Util.cleanAll();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  NavigationPage.LoginPage,
                  (route) => false,
                );
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    var user = _util.getUserDetail();
    var argument = widget.navigationParams;

    if (argument == null) {
      argument = NavigationParams(isChildPage: false, pageName: "Dashboard");
    }

    // User user = Provider.of<AppData>(context, listen: false).user;
    setState(() {
      _user = user;
      _isLoggingOut = false;
      _arg = argument!;
    });
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      color: Colors.white,
      margin: const EdgeInsets.only(
        top: 0,
        left: 0,
        right: 0,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 0,
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
                _arg.isChildPage
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
                  _arg.pageName!,
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
            !_arg.isChildPage
                ? const SizedBox(
                    height: 20,
                  )
                : SizedBox.shrink(),
            !_arg.isChildPage ? getUserDetailWidget() : SizedBox.shrink(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
