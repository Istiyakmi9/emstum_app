import 'package:flutter/material.dart';

class NavigationPage {
  static const String DashboardPage = "dashboard";
  static const String AttendancePage = "attendance";
  static const String TrackPage = "track";
  static const String ProfilePage = "profile";
  static const String LoginPage = "login";
  static const String HomePage = "home";
  static const String ApplyAttendancePage = "applyAttendancePage";
  static const String CalendarPage = "calendar";
  static const String ReferralPage = "referral";
  static const String SalaryStatement = "salary_statement";
  static const String MyTiming = "my_timing";
  static const String FilesAndDocuments = "file_documents";
  static const String DailyActivity = "daily_activity";
  static const String AttendanceLeaveApproval = "attendance_leave_approval";

  static const int DashboardIndex = 0;
  static const int AttendanceIndex = 1;
  static const int LeaveIndex = 2;
  static const int ProfileIndex = 3;
  static const int LoginIndex = 4;

  static void navigateToPage(String pageName, BuildContext context, {dynamic argument = null}) {
    Navigator.pushNamed(
      context,
      NavigationPage.CalendarPage,
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