import 'package:bot_org_manage/screens/dashboard/widgets/userinfo.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';

class EmployeeTimingReports extends StatefulWidget {
  const EmployeeTimingReports({Key? key}) : super(key: key);

  @override
  State<EmployeeTimingReports> createState() => _EmployeeTimingReportsState();
}

class _EmployeeTimingReportsState extends State<EmployeeTimingReports> {
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
                pageName: "Attendance Timing",
              ),
            ),
            NavigationPage.GetUnderconstructionPage(),
          ],
        ),
      ),
    );
  }
}