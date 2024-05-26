import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/screens/common/page_header/header_index.dart';
import 'package:bot_org_manage/screens/common/page_header_info/user_info_detail.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/action_grids.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/attendance_graph.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/employee_quickview.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/userinfo.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Function? changeMenu;

  Dashboard({super.key, required this.changeMenu});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Util _util = Util();
  User? _user;

  void _loadMapPage() {
    Navigator.of(context).pushNamed(Navigate.apply);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Configuration.ColorFromHex("#eeeeee"),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderIndex(
              isChildPage: false,
            ),
            UserInfoDetail(),
            EmployeeQuickViews(
              changeMenu: widget.changeMenu,
            ),
            ActionGrids(),
            const AttendanceGraph(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
