import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/screens/attendance/attendance.dart';
import 'package:bot_org_manage/screens/attendance/profile_detail/profile.dart';
import 'package:bot_org_manage/screens/dashboard/dashboard.dart';
import 'package:bot_org_manage/screens/leave/leave.dart';
import 'package:bot_org_manage/screens/login/login.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var pageIndex = 0.obs;
  User? user;

  void loadPageOnTap(int index) {
    pageIndex.value = index;
  }

  void ChangeMenuPage(int pageIndex) {
    debugPrint("activate menu: $pageIndex");
    loadPageOnTap(pageIndex);
  }

  Widget getWidgetByIndex(int pageIndex) {
    Widget page = Dashboard(
      changeMenu: ChangeMenuPage,
    );
    switch (pageIndex) {
      case Navigate.DashboardIndex:
        page = Dashboard(
          changeMenu: ChangeMenuPage,
        );
        break;
      case Navigate.ProfileIndex:
        page = const Profile();
        break;
      case Navigate.AttendanceIndex:
        page = const AttendanceIndexPage();
        break;
      case Navigate.LeaveIndex:
        page = LeaveIndexPage();
        break;
      case Navigate.LoginIndex:
        page = const Login();
        break;
    }

    return page;
  }

  List<BottomNavigationBarItem> getMenuItems() {
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageIndex.value = Navigate.DashboardIndex;
    user = User();
  }
}
