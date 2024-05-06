import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class Leaves {
  int leaveRequestNotificationId = 0;
  int? leaveRequestId = 0;
  String? userMessage;
  DateTime? fromDate;
  DateTime? toDate;
  double numOfDays = 0;
  int requestStatusId = 0;
  int leaveTypeId = 0;
  int noOfApprovalsRequired = 0;
  String? reporterDetail;
  String? fileIds;
  String? leaveTypeName;
  String? managerName;
  String? managerEmail;
  DateTime? createdOn;
  String? status;
  String? color;

  Leaves();

  Leaves.fromLeaves(
    this.leaveRequestNotificationId,
    this.leaveRequestId,
    this.userMessage,
    this.fromDate,
    this.toDate,
    this.numOfDays,
    this.requestStatusId,
    this.leaveTypeId,
    this.noOfApprovalsRequired,
    this.reporterDetail,
    this.fileIds,
    this.leaveTypeName,
    this.managerName,
    this.managerEmail,
    this.createdOn,
    this.status,
    this.color,
  );

  factory Leaves.fromJson(dynamic data, Util util) {
    return Leaves.fromLeaves(
        data["LeaveRequestNotificationId"],
        data["LeaveRequestId"],
        data["UserMessage"],
        Jiffy(data["FromDate"]).dateTime,
        Jiffy(data["ToDate"]).dateTime,
        data["NumOfDays"],
        data["RequestStatusId"],
        data["LeaveTypeId"],
        data["NoOfApprovalsRequired"],
        data["ReporterDetail"],
        data["FileIds"],
        data["LeaveTypeName"],
        data["ManagerName"],
        data["ManagerEmail"],
        Jiffy(data["CreatedOn"]).dateTime,
        util.getStatusName(data["RequestStatusId"]),
        util.getStatusColor(data["RequestStatusId"]));
  }
}
