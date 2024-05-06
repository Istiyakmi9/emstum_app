import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/action_grids.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/attendance_graph.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/employee_quickview.dart';
import 'package:bot_org_manage/screens/dashboard/widgets/userinfo.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Navigator.of(context).pushNamed(NavigationPage.ApplyAttendancePage);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var user = _util.getUserDetail();
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Configuration.ColorFromHex("#eeeeee"),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            UserInfo(
              navigationParams: NavigationParams(
                isChildPage: false,
                pageName: "Dashboard",
              ),
            ),
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
