import 'dart:io';

import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/appData.dart';
import 'package:bot_org_manage/modal/attendaceModal.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/screens/approval/attendance_leavel_approval.dart';
import 'package:bot_org_manage/screens/attendance/attendance.dart';
import 'package:bot_org_manage/screens/dashboard/dashboard.dart';
import 'package:bot_org_manage/screens/employee_timing/employee_timing_report.dart';
import 'package:bot_org_manage/screens/file_and_documents/file_and_documents.dart';
import 'package:bot_org_manage/screens/home_layout/home.dart';
import 'package:bot_org_manage/screens/leave/widget/calendar.dart';
import 'package:bot_org_manage/screens/login/login.dart';
import 'package:bot_org_manage/screens/attendance/widgets/applyAttendancePage.dart';
import 'package:bot_org_manage/screens/attendance/profile_detail/profile.dart';
import 'package:bot_org_manage/screens/leave/leave.dart';
import 'package:bot_org_manage/screens/referral/refferral.dart';
import 'package:bot_org_manage/screens/salary_detail/salary_statements.dart';
import 'package:bot_org_manage/screens/todays_activity/daily_activity.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureUtil();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const MyApp(),
    ),
  );
}

Future<void> configureUtil() async {
  var pref = await SharedPreferences.getInstance();
  Util.init(pref);
  Util.getSharedPreferences();
  Util.cleanAll();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ColorScheme colorScheme = const ColorScheme(
    // primary: Color.fromRGBO(21, 26, 74, 1),
    primary: Color.fromRGBO(21, 26, 74, 1),
    // <---- I set white color here
    secondary: Color(0x44444444),
    // background: Color(0xFF636363),
    background: Color(0xffffffff),
    surface: Color(0xFF808080),
    onBackground: Colors.white,
    error: Colors.redAccent,
    onError: Colors.redAccent,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  build(BuildContext context) {
    Configuration.width = MediaQuery.of(context).size.width;
    Configuration.height = MediaQuery.of(context).size.height;
    Configuration.isAndroid = Platform.isAndroid;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: Navigate.profile, page: () => const Profile()),
        GetPage(
            name: Navigate.attendance,
            page: () => const AttendanceIndexPage()),
        GetPage(name: Navigate.track, page: () => LeaveIndexPage()),
        GetPage(name: Navigate.login, page: () => const Login()),
        GetPage(name: Navigate.calendar, page: () => Calendar()),
        GetPage(name: Navigate.referral, page: () => Referrals()),
        GetPage(name: Navigate.salaryStatement, page: () => SalaryStatements()),
        GetPage(name: Navigate.myTiming, page: () => EmployeeTimingReports()),
        GetPage(
            name: Navigate.filesAndDocuments, page: () => FileAndDocuments()),
        GetPage(name: Navigate.dailyActivity, page: () => DailyActivity()),
        GetPage(
            name: Navigate.attendanceLeaveApproval,
            page: () => AttendanceLeaveApproval()),
        GetPage(
            name: Navigate.apply,
            page: () => ApplyAttendance(attendanceModal: AttendanceModal())),
      ],
      unknownRoute:
          GetPage(name: Navigate.login, page: () => const Login()),
      theme: ThemeData(
        colorScheme: colorScheme,
      ),
    );
  }
}
