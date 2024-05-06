import 'package:bot_org_manage/screens/dashboard/widgets/userinfo.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _flag = false;

  Future<void> _reloadData() async {
    setState(() {
      _flag = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _flag = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reloadData,
      child: Column(
        children: [
          UserInfo(
            navigationParams: NavigationParams(
              isChildPage: false,
              pageName: "Profile",
            ),
          ),
          NavigationPage.GetUnderconstructionPage(),
        ],
      ),
    );
  }
}
