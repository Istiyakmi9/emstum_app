import 'package:bot_org_manage/modal/appData.dart';
import 'package:bot_org_manage/modal/attendaceModal.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/screens/approval/attendance_leavel_approval.dart';
import 'package:bot_org_manage/screens/attendance/attendanceIndexPage.dart';
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
    background: Color(0xFF636363),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        // NavigationPage.DashboardPage: (_) => Dashboard(changeMenu: null),
        NavigationPage.ProfilePage: (_) => const Profile(),
        NavigationPage.AttendancePage: (_) => const AttendanceIndexPage(),
        NavigationPage.TrackPage: (_) => LeaveIndexPage(),
        NavigationPage.LoginPage: (_) => const Login(),
        NavigationPage.CalendarPage: (_) => Calendar(),
        NavigationPage.ReferralPage: (_) => Referrals(),
        NavigationPage.SalaryStatement: (_) => SalaryStatements(),
        NavigationPage.MyTiming: (_) => EmployeeTimingReports(),
        NavigationPage.FilesAndDocuments: (_) => FileAndDocuments(),
        NavigationPage.DailyActivity: (_) => DailyActivity(),
        NavigationPage.AttendanceLeaveApproval: (_) => AttendanceLeaveApproval(),
        NavigationPage.ApplyAttendancePage: (_) =>
            ApplyAttendance(attendanceModal: AttendanceModal()),
        NavigationPage.HomePage: (_) => Home(NavigationPage.DashboardIndex),
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (_) => const Login());
      },
      // home: Home(NavigationPage.DashboardIndex),
      home: const Login(),
      theme: ThemeData(
          colorScheme: colorScheme,
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 16, color: colorScheme.primary),
            headline1: TextStyle(fontSize: 18, color: colorScheme.primary),
            headline2: TextStyle(fontSize: 20, color: colorScheme.primary),
            button: const TextStyle(fontSize: 12),
          )),
    );
  }
}
