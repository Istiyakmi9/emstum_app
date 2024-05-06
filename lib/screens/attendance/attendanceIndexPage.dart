import 'dart:convert';

import 'package:bot_org_manage/modal/appData.dart';
import 'package:bot_org_manage/modal/attendaceModal.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/screens/attendance/widgets/attendanc.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../dashboard/widgets/userinfo.dart';

class AttendanceIndexPage extends StatefulWidget {
  const AttendanceIndexPage({super.key});

  @override
  State<AttendanceIndexPage> createState() => _AttendanceIndexPageState();
}

class _AttendanceIndexPageState extends State<AttendanceIndexPage> {
  bool _flag = true;
  List<AttendanceModal> _attendances = [];
  final Ajax ajax = Ajax.getInstance();
  late User user;
  List<bool> _selections = [];
  var _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selections = List.generate(2, (_) => false);
    _selections[0] = true;
    _loadEmployeeAttendanceDetail(_currentDate);
  }

  Future _loadEmployeeAttendanceDetail(DateTime now) async {
    user = Provider.of<AppData>(context, listen: false).user;
    var presentDay = DateTime.now();
    ajax.post("Attendance/GetattendanceByUserId", {
      "EmployeeId": user.UserId,
      "ForYear": now.year,
      "ForMonth": now.month,
      "AttendenceDay": Jiffy(now).format(),
      // Ajax.convertToServerDateTime(DateTime(presentDay.year, presentDay.month)),
    }).then((data) {
      List<dynamic> result = data["AttendacneDetails"];
      int attendanceId = data["AttendanceId"];

      _attendances = [];
      int i = 0;
      while (i < result.length) {
        _attendances.add(AttendanceModal.fromJson(result[i], attendanceId));
        i++;
      }

      setState(() {
        _flag = false;
        _selections = _selections;
        _attendances = _attendances;
        _currentDate = _currentDate;
      });
    }).catchError((err) {
      setState(() {
        _flag = false;
      });
      debugPrint(err);
    });
  }

  Future<void> _reloadData() async {
    setState(() {
      _flag = true;
    });

    _loadEmployeeAttendanceDetail(_currentDate);
  }

  void _reLoadOnUpdate(String result) {
    setState(() {
      _flag = true;
    });

    _loadEmployeeAttendanceDetail(_currentDate);
  }

  Widget buildPage() {
    if (_flag) {
      return const Center(
        child: RefreshProgressIndicator(),
      );
    } else {
      if (_attendances.isNotEmpty) {
        return Provider(
          create: (context) => _attendances,
          child: Attendance(reLoadPage: _reLoadOnUpdate),
        );
      } else {
        return const Center(
          child: Text("No record found."),
        );
      }
    }
  }

  Widget _attendanceHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Your Attendance"),
          ToggleButtons(
            isSelected: _selections,
            onPressed: (index) {
              var items = List.generate(2, (_) => false);
              DateTime date =
                  Jiffy(DateTime.now()).subtract(months: index).dateTime;
              items[index] = !items[index];
              setState(() {
                _selections = items;
                _currentDate = date;
                _flag = true;
              });

              SchedulerBinding.instance.addPostFrameCallback((_) {
                _loadEmployeeAttendanceDetail(date);
              });
            },
            fillColor: Colors.orangeAccent,
            borderColor: Colors.lightBlueAccent,
            selectedBorderColor: Colors.red,
            color: Colors.black,
            selectedColor: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            children: const [
              Text("Oct"),
              Text("Sep"),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reloadData,
      child: Column(
        children: [
          UserInfo(
            navigationParams:
                NavigationParams(isChildPage: false, pageName: "Attendance"),
          ),
          _attendanceHeader(),
          Expanded(
            child: buildPage(),
          ),
        ],
      ),
    );
  }
}
