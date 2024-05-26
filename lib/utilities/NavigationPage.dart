import 'package:flutter/material.dart';

class Navigate {
  static const String dashboard = "/dashboard";
  static const String attendance = "/attendance";
  static const String track = "/track";
  static const String profile = "/profile";
  static const String login = "/login";
  static const String home = "/home";
  static const String apply = "/applyAttendancePage";
  static const String calendar = "/calendar";
  static const String referral = "/referral";
  static const String salaryStatement = "/salary_statement";
  static const String myTiming = "/my_timing";
  static const String filesAndDocuments = "/file_documents";
  static const String dailyActivity = "/daily_activity";
  static const String attendanceLeaveApproval = "/attendance_leave_approval";

  static const int DashboardIndex = 0;
  static const int AttendanceIndex = 1;
  static const int LeaveIndex = 2;
  static const int ProfileIndex = 3;
  static const int LoginIndex = 4;

  static void navigateToPage(String pageName, BuildContext context, {dynamic argument = null}) {
    Navigator.pushNamed(
      context,
      Navigate.calendar,
      arguments: null,
    ).then((value) {
      // write your login here
    });
  }

  static Widget GetUnderconstructionPage() {
    return Container(
      color: const Color(0x44e1e5eb),
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/placeholder.jpeg",
            height: 200,
            width: 400,
          ),
          const SizedBox(
            height: 25,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: const [
              Text(
                "This page is under construction",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: Text(
                  "This page will allow user to book their vehicle for the servicing. In upcoming version there is lot's of new feature we are going to add.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class NavigationParams {
  bool isChildPage;
  String? pageName;
  dynamic data;

  NavigationParams({
    required this.isChildPage,
    this.pageName = null,
    this.data = null,
  });
}