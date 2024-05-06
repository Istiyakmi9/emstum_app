import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/attendaceModal.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class AttendanceDetail extends StatelessWidget {
  AttendanceModal attendanceModal;
  AttendanceDetail({Key? key, required this.attendanceModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "Apply For ${attendanceModal.attendanceDay}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                Jiffy(attendanceModal.date, "yyyy-MM-dd").format("do MMM, yyyy"),
              ),
              trailing: Text(
                attendanceModal.grossHours,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Image.asset(attendanceModal.leadingIcon, width: 40,),
            ),
          ],
        ),
      ),
    );
  }
}
