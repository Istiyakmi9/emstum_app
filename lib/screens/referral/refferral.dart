import 'package:bot_org_manage/screens/dashboard/widgets/userinfo.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';

class Referrals extends StatelessWidget {
  Referrals({Key? key}) : super(key: key);

  bool _flag = false;

  Future<void> _reloadData() async {}

  @override
  Widget build(BuildContext context) {
    final param =
        ModalRoute.of(context)!.settings.arguments as NavigationParams;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _reloadData,
        child: Column(
          children: [
            UserInfo(
              navigationParams: NavigationParams(
                isChildPage: param.isChildPage,
                pageName: "Referral",
              ),
            ),
            NavigationPage.GetUnderconstructionPage(),
          ],
        ),
      ),
    );
  }
}
