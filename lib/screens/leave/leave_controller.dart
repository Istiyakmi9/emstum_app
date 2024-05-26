import 'package:bot_org_manage/modal/LeaveTypeBrief.dart';
import 'package:bot_org_manage/modal/Leaves.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LeaveController extends GetxController {
  var isLoaded = false.obs;
  var isRedirect = false.obs;

  final Ajax _ajax = Ajax.getInstance();
  var util = Util();
  User user = User();
  List<Leaves> leaves = <Leaves>[];
  List<LeaveTypeBrief> brief = [];

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

    leaves = leaves;
    brief = brief;
    isLoaded.value = true;
    isRedirect.value = false;
  }

  Future<void> loadLeaveData() async {
    _ajax.post("Leave/GetAllLeavesByEmpId",
        {"EmployeeId": user.EmployeeId}).then((value) async {
      if (value == null) {
        Fluttertoast.showToast(msg: "Fail to get result.");
      } else {
        var status = await validateResponse(value);
        if (status == 0 || status == 2) {
          calculateAndLoadData(value);
        }
      }
    });
  }

  updateRedirect(bool flag) {
    isRedirect.value = flag;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    util = Util();
    user = util.getUserDetail();
    isLoaded.value = false;
    isRedirect.value = false;
    loadLeaveData();
  }
}
