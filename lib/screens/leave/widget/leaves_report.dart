import 'dart:convert';

import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/LeaveTypeBrief.dart';
import 'package:bot_org_manage/modal/Leaves.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/screens/leave/leave_controller.dart';
import 'package:bot_org_manage/screens/leave/widget/apply_leave.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class LeavesReport extends StatefulWidget {
  const LeavesReport({Key? key}) : super(key: key);

  @override
  State<LeavesReport> createState() => _LeavesReportState();
}

class _LeavesReportState extends State<LeavesReport> {
  var controller = Get.put(LeaveController());

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
            child: ApplyLeave(),
          ),
          controller.leaves.isEmpty
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
                    itemCount: controller.leaves.length,
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
                                    controller.leaves[index].color!),
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
                                  Jiffy(controller.leaves[index].fromDate)
                                      .format("MMM"),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            title: Text(
                              Jiffy(controller.leaves[index].fromDate)
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
                                    Text(
                                        "Days: ${controller.leaves[index].numOfDays}"),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                        "(${controller.leaves[index].leaveTypeName!})"),
                                  ],
                                ),
                                Text(
                                  controller.leaves[index].status!,
                                  style: TextStyle(
                                    color: Configuration.ColorFromHex(
                                        controller.leaves[index].color!),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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
