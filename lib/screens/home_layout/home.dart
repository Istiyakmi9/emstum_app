import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/screens/attendance/attendanceIndexPage.dart';
import 'package:bot_org_manage/screens/dashboard/dashboard.dart';
import 'package:bot_org_manage/screens/home_layout/drawer_menu.dart';
import 'package:bot_org_manage/screens/leave/leave.dart';
import 'package:bot_org_manage/screens/login/login.dart';
import 'package:bot_org_manage/screens/attendance/profile_detail/profile.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../modal/user.dart';

class Home extends StatefulWidget {
  int pageIndex;

  Home(this.pageIndex);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  late User _user;

  @override
  void initState() {
    super.initState();

    setState(() {
      pageIndex = widget.pageIndex;
      _user = User();
    });
  }

  void _loadPageOnTap(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  List<BottomNavigationBarItem> _getMenuItems() {
    List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.location_searching),
        label: "Attendance",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: "Leave",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: "Profile",
      ),
    ];

    return items;
  }

  AppBar _getAppBar() {
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
            "${_user.FirstName} ${_user.LastName}",
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
                NavigationPage.LoginPage, (route) => false);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.power_settings_new_outlined,
            color: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                NavigationPage.LoginPage, (route) => false);
          },
        )
      ],
    );
  }

  void ChangeMenuPage(int pageIndex) {
    debugPrint("activate menu: $pageIndex");
    _loadPageOnTap(pageIndex);
  }

  Widget GetWidgetByIndex(int pageIndex) {
    Widget page = Dashboard(
      changeMenu: ChangeMenuPage,
    );
    switch (pageIndex) {
      case NavigationPage.DashboardIndex:
        page = Dashboard(
          changeMenu: ChangeMenuPage,
        );
        break;
      case NavigationPage.ProfileIndex:
        page = const Profile();
        break;
      case NavigationPage.AttendanceIndex:
        page = const AttendanceIndexPage();
        break;
      case NavigationPage.LeaveIndex:
        page = LeaveIndexPage();
        break;
      case NavigationPage.LoginIndex:
        page = const Login();
        break;
    }

    return page;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Fluttertoast.showToast(msg: "Please close you application if you want to exit.");
        return Future.value(false);
      },
      child: Scaffold(
        // appBar: _getAppBar(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          onTap: _loadPageOnTap,
          items: _getMenuItems(),
          type: BottomNavigationBarType.fixed,
        ),
        drawer: Drawer(
          child: DrawerMenu(),
        ),
        body: GetWidgetByIndex(pageIndex),
      ),
    );
  }
}
