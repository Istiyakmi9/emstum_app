import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:jiffy/jiffy.dart';

class ApprovalModel {
  int AttendanceId = 0;
  int EmployeeId = 0;
  int ReportingManagerId = 0;
  String EmployeeName = Configuration.StringDefault;
  String? FirstName = Configuration.StringDefault;
  String? LastName = Configuration.StringDefault;
  String Email = Configuration.StringDefault;
  String Mobile = Configuration.StringDefault;
  String ManagerName = Configuration.StringDefault;
  String ManagerMobile = Configuration.StringDefault;
  String ManagerEmail = Configuration.StringDefault;
  int Total = 0;
  int Index = 0;
  int PageIndex = 0;
  int AttendenceDetailId = 0;
  String AttendanceDay = "dd/MM/yyyy";
  String Day = "None";
  String AttendanceDate = "dd/MM/yyyy";
  String LogOn = Configuration.StringDefault;
  String LogOff = Configuration.StringDefault;
  int PresentDayStatus = 0;
  String UserComments = Configuration.StringDefault;
  int ApprovedBy = 0;
  int SessionType = 0;
  int TotalMinutes = 0;
  int WorkTypeId = 0;

  ApprovalModel.fromApprovalModel(
    this.AttendanceId,
    this.EmployeeId,
    this.ReportingManagerId,
    this.EmployeeName,
    this.FirstName,
    this.LastName,
    this.Email,
    this.Mobile,
    this.ManagerName,
    this.ManagerMobile,
    this.ManagerEmail,
    this.Total,
    this.Index,
    this.PageIndex,
    this.AttendenceDetailId,
    this.AttendanceDay,
    this.Day,
    this.AttendanceDate,
    this.LogOn,
    this.LogOff,
    this.PresentDayStatus,
    this.UserComments,
    this.ApprovedBy,
    this.SessionType,
    this.TotalMinutes,
    this.WorkTypeId,
  );

  static Map<String, dynamic> toJson(ApprovalModel data) {
    return {
      "AttendanceId": data.AttendanceId,
      "EmployeeId": data.EmployeeId,
      "ReportingManagerId": data.ReportingManagerId,
      "EmployeeName": data.EmployeeName,
      "FirstName": data.FirstName,
      "LastName": data.LastName,
      "Email": data.Email,
      "Mobile": data.Mobile,
      "ManagerName": data.ManagerName,
      "ManagerMobile": data.ManagerMobile,
      "ManagerEmail": data.ManagerEmail,
      "Total": data.Total,
      "Index": data.Index,
      "PageIndex": data.PageIndex,
      "AttendenceDetailId": data.AttendenceDetailId,
      "AttendanceDay": data.AttendanceDay,
      "LogOn": data.LogOn,
      "LogOff": data.LogOff,
      "PresentDayStatus": data.PresentDayStatus,
      "UserComments": data.UserComments,
      "ApprovedBy": data.ApprovedBy,
      "SessionType": data.SessionType,
      "TotalMinutes": data.TotalMinutes,
      "WorkTypeId": data.WorkTypeId,
    };
  }

  factory ApprovalModel.fromJson(dynamic data) {
    var date = User.toDateTime(data["AttendanceDay"]);
    return ApprovalModel.fromApprovalModel(
      data["AttendanceId"],
      data["EmployeeId"],
      data["ReportingManagerId"],
      data["EmployeeName"],
      data["FirstName"],
      data["LastName"],
      data["Email"],
      data["Mobile"],
      data["ManagerName"],
      data["ManagerMobile"],
      data["ManagerEmail"],
      data["Total"],
      data["Index"],
      data["PageIndex"],
      data["AttendenceDetailId"],
      data["AttendanceDay"],
      Jiffy(date, "yyyy-MM-dd").EEEE,
      Jiffy(data["AttendanceDay"]).format("do MMMM, yyyy"),
      data["LogOn"],
      data["LogOff"],
      data["PresentDayStatus"],
      data["UserComments"],
      data["ApprovedBy"],
      data["SessionType"],
      data["TotalMinutes"],
      data["WorkTypeId"],
    );
  }
}
