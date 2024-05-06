import 'package:bot_org_manage/modal/Configuration.dart';

class LeaveTypeBrief {
  int leavePlanTypeId = 0;
  String leavePlanTypeName = Configuration.StringDefault;
  double availableLeaves = 0.0;
  double totalLeaveQuota = 0.0;
  bool isCommentsRequired = false;
  bool isFutureDateAllowed = false;
  bool isHalfDay = false;
  double accuredSoFar = 0.0;

  LeaveTypeBrief.fromLeaveTypeBrief(this.leavePlanTypeId,
    this.leavePlanTypeName,
    this.availableLeaves,
    this.totalLeaveQuota,
    this.isCommentsRequired,
    this.isFutureDateAllowed,
    this.isHalfDay,
    this.accuredSoFar,
  );

  factory LeaveTypeBrief.fromJson(dynamic data) {
    return LeaveTypeBrief.fromLeaveTypeBrief(
      data["LeavePlanTypeId"],
      data["LeavePlanTypeName"],
      data["AvailableLeaves"],
      data["TotalLeaveQuota"],
      data["IsCommentsRequired"],
      data["IsFutureDateAllowed"],
      data["IsHalfDay"],
      data["AccruedSoFar"],);
  }
}
