import 'package:bot_org_manage/screens/attendance/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class AttendanceHeader extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Your Attendance"),
          ToggleButtons(
            isSelected: controller.selections,
            onPressed: (index) => controller.switchMonth(index),
            fillColor: Colors.orangeAccent,
            borderColor: Colors.lightBlueAccent,
            selectedBorderColor: Colors.red,
            color: Colors.black,
            selectedColor: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            children: [
              Text(
                Jiffy(DateTime.now()).format("MMM"),
              ),
              Text(
                Jiffy(DateTime(DateTime.now().year, DateTime.now().month - 1))
                    .format("MMM"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
