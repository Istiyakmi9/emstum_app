import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/utilities/constants.dart';
import 'package:jiffy/jiffy.dart';

class AttendanceModal {
  String attendanceDay = Constants.Empty;
  int attendenceDetailId = 0;
  int attendanceId = 0;
  DateTime date = DateTime.now();
  int totalMinutes = 0;
  String userComments = Constants.Empty;
  int attendanceStatus = 0;
  String employeeName = Constants.Empty;
  String email = Constants.Empty;
  String mobile = Constants.Empty;
  String effectiveHours = Constants.Empty;
  String grossHours = Constants.Empty;
  String leadingIcon = Constants.Empty;
  String tralingIcon = Constants.Empty;
  String statusMessage = Constants.Empty;
  bool isWeekend = false;
  bool isOpen = false;
  bool isOnLeave = false;
  String color = "#000000";
  String cardBorder = "#000000";
  int presentDayStatus = 1;
  int employeeId = 0;
  int userTypeId = 2;

  AttendanceModal();

  AttendanceModal.fromAttendance(
    this.attendanceDay,
    this.attendanceId,
    this.attendenceDetailId,
    this.email,
    this.mobile,
    this.attendanceStatus,
    this.date,
    this.effectiveHours,
    this.employeeName,
    this.grossHours,
    this.userComments,
    this.totalMinutes,
    this.presentDayStatus,
    this.isWeekend,
    this.isOnLeave,
    this.isOpen
  );

  factory AttendanceModal.fromJson(dynamic data, int attendanceId) {
    var date = User.toDateTime(data["AttendanceDay"]);
    return AttendanceModal.fromAttendance(
      Jiffy(date, "yyyy-MM-dd").EEEE,
      attendanceId,
      data["AttendenceDetailId"],
      "n/a",
      "n/a",
      data["PresentDayStatus"],
      date,
      "9h 0m",
      "N/A",
      "9h 0m",
      data["UserComments"],
      360,
      data["PresentDayStatus"],
      data["IsWeekend"],
      data["IsOnLeave"],
      data["IsOpen"],
    );
  }
}
