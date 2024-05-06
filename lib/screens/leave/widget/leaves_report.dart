import 'dart:convert';

import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/LeaveTypeBrief.dart';
import 'package:bot_org_manage/modal/Leaves.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';

class LeavesReport extends StatefulWidget {
  const LeavesReport({Key? key}) : super(key: key);

  @override
  State<LeavesReport> createState() => _LeavesReportState();
}

class _LeavesReportState extends State<LeavesReport> {
  bool _isLoaded = false;
  bool _isRedirect = false;
  final Ajax _ajax = Ajax.getInstance();
  User _user = User();
  List<Leaves> _leaves = <Leaves>[];
  List<LeaveTypeBrief> _brief = [];

  Future<int> validateResponse(dynamic result) async {
    int isPassed = 0;
    if (result == null) {
      Fluttertoast.showToast(msg: "Invalid response for the leaves");
      isPassed = 1;
    }

    if (result["LeaveNotificationDetail"] == null) {
      Fluttertoast.showToast(msg: "Leave detail not found");
      isPassed = 2;
    }

    if (result["LeaveTypeBriefs"] == null) {
      Fluttertoast.showToast(
          msg: "Leave type not found. Please contact to admin.");
      isPassed = 1;
    }

    return isPassed;
  }

  Future<void> calculateAndLoadData(dynamic value) async {
    var util = Util();
    var leaves = <Leaves>[];
    var leaveNotifications = value["LeaveNotificationDetail"];

    int i = 0;
    while (i < leaveNotifications.length) {
      leaves.add(Leaves.fromJson(leaveNotifications[i], util));
      i++;
    }

    List<LeaveTypeBrief> brief = [];
    var leaveTypeBrief = value["LeaveTypeBriefs"];
    i = 0;
    while (i < leaveTypeBrief.length) {
      brief.add(LeaveTypeBrief.fromJson(leaveTypeBrief[i]));
      i++;
    }

    setState(() {
      _leaves = leaves;
      _brief = brief;
      _isLoaded = true;
      _isRedirect = false;
    });
  }

  Future<void> loadLeaveData() async {
    _ajax.post("Leave/GetAllLeavesByEmpId",
        {"EmployeeId": _user.EmployeeId}).then((value) async {
      var status = await validateResponse(value);
      if (status == 0 || status == 2) {
        calculateAndLoadData(value);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    var util = Util();
    _user = util.getUserDetail();

    setState(() {
      _isLoaded = false;
      _user = _user;
      _isRedirect = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loadLeaveData();
    });
  }

  Widget applySection(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("User name"),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isRedirect = true;
            });

            Navigator.pushNamed(
              ctx,
              NavigationPage.CalendarPage,
              arguments: _brief,
            ).then((value) {
              if (value == null) {
                setState(() {
                  _isRedirect = false;
                });
              } else {
                calculateAndLoadData(value);
              }
            });
          },
          icon: _isRedirect
              ? SizedBox(
                  width: Configuration.getLoaderSize,
                  height: Configuration.getLoaderSize,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Icon(
                  // <-- Icon
                  Icons.rocket_launch_outlined,
                  size: 24.0,
                ),
          label: const Text('Apply Now'), // <-- Text
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: Configuration.height * 0.02,
              left: Configuration.width * 0.03,
              right: Configuration.width * 0.03,
            ),
            child: applySection(context),
          ),
          _leaves.isEmpty
              ? const Center(
                  child: Text("No record found"),
                )
              : Container(
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: 10,
                    left: 4,
                    right: 4,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _leaves.length,
                    padding: EdgeInsets.symmetric(
                      vertical: Configuration.height * 0.02,
                      horizontal: Configuration.width * 0.02,
                    ),
                    itemBuilder: (ctx, index) {
                      return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            // borderRadius: BorderRadius.circular(4),
                            border: Border(
                              left: BorderSide(
                                color: Configuration.ColorFromHex(
                                    _leaves[index].color!),
                                width: 6,
                              ),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 218, 218, 218),
                                blurRadius: 2.0, // soften the shadow
                                spreadRadius: 2.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  2.0, // Move to bottom 10 Vertically
                                ),
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {},
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  Jiffy(_leaves[index].fromDate).format("MMM"),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            title: Text(
                              Jiffy(_leaves[index].fromDate)
                                  .format("do MMMM, yyyy"),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: [
                                    Text("Days: ${_leaves[index].numOfDays}"),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text("(${_leaves[index].leaveTypeName!})"),
                                  ],
                                ),
                                Text(
                                  _leaves[index].status!,
                                  style: TextStyle(
                                    color: Configuration.ColorFromHex(
                                        _leaves[index].color!),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                // Image.asset(
                                //   leaves[index].tralingIcon,
                                //   width: 20,
                                // ),
                                Icon(Icons.more_vert_rounded),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
