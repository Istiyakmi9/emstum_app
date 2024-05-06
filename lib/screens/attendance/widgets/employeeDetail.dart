import 'package:bot_org_manage/modal/attendaceModal.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:flutter/material.dart';

class EmployeeDetail extends StatelessWidget {
  final AttendanceModal attendanceModal;
  EmployeeDetail({Key? key, required this.attendanceModal})
      : super(key: key);

  User user = User();

  Widget getEmployeeDetailTable(BuildContext ctx) {
    return Column(
      children: [
        ListTile(
          title: const Text("Employee Name"),
          leading: const Icon(Icons.person),
          subtitle: Text("${user.FirstName} ${user.LastName}"),
        ),
        ListTile(
          title: const Text("Mobile no#"),
          leading: const Icon(Icons.phone_android_outlined),
          subtitle: Text(user.Mobile),
        ),
        ListTile(
          title: const Text("Email Id"),
          leading: const Icon(Icons.email_outlined),
          subtitle: Text(user.Email),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.only(top: 10.0),
          child: getEmployeeDetailTable(context),
        ),
      ],
    );
  }
}
