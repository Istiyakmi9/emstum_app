import 'package:bot_org_manage/modal/attendaceModal.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class AttendanceController extends GetxController {
  var pageFlag = true.obs;
  final Util util = Util.util;
  List<AttendanceModal> attendances = [];
  final Ajax ajax = Ajax.getInstance();
  User? user;
  List<bool> selections = [];
  var currentDate = DateTime.now();

  void updateFlag(bool flag) {
    pageFlag.value = flag;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selections = List.generate(2, (_) => false);
    selections[0] = true;
    loadEmployeeAttendanceDetail(currentDate);
  }

  void switchMonth(int index) {
    var items = List.generate(2, (_) => false);
    DateTime date =
        Jiffy(DateTime.now()).subtract(months: index).dateTime;
    items[index] = !items[index];
    selections = items;
    currentDate = date;
    updateFlag(true);
    loadEmployeeAttendanceDetail(date);
  }

  Future loadEmployeeAttendanceDetail(DateTime now) async {
    user = util.getUserDetail();
    var presentDay = DateTime.now();
    ajax.post("core/Attendance/GetAttendanceByUserId", {
      "EmployeeId": user!.UserId,
      "ForYear": now.year,
      "ForMonth": now.month,
      "AttendenceDay": Jiffy(now).format(),
      // Ajax.convertToServerDateTime(DateTime(presentDay.year, presentDay.month)),
    }).then((data) {
      List<dynamic> result = data["AttendacneDetails"];
      int attendanceId = data["AttendanceId"];

      attendances = [];
      int i = 0;
      while (i < result.length) {
        attendances.add(AttendanceModal.fromJson(result[i], attendanceId));
        i++;
      }

      pageFlag.value = false;
    }).catchError((err) {
      pageFlag.value = false;
    });
  }

  Future<void> reloadData() async {
    pageFlag.value = true;
    loadEmployeeAttendanceDetail(currentDate);
  }

  void reLoadOnUpdate(String result) {
    pageFlag.value = true;
    loadEmployeeAttendanceDetail(currentDate);
  }
}