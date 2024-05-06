import 'package:bot_org_manage/screens/leave/widget/leaves_report.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';

import '../dashboard/widgets/userinfo.dart';

class LeaveIndexPage extends StatelessWidget {
  final presentDate = DateTime.now();

  LeaveIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserInfo(
          navigationParams: NavigationParams(
            isChildPage: false,
            pageName: "Leave",
          ),
        ),
        LeavesReport(),
      ],
    );
  }
}
