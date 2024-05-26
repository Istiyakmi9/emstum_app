import 'package:bot_org_manage/screens/attendance/attendance_controller.dart';
import 'package:bot_org_manage/screens/attendance/widgets/attendanc_cards.dart';
import 'package:bot_org_manage/screens/attendance/widgets/attendance_header.dart';
import 'package:bot_org_manage/screens/common/page_header/header_index.dart';
import 'package:bot_org_manage/screens/common/page_header_info/user_info_detail.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../dashboard/widgets/userinfo.dart';

class AttendanceIndexPage extends StatefulWidget {
  const AttendanceIndexPage({super.key});

  @override
  State<AttendanceIndexPage> createState() => _AttendanceIndexPageState();
}

class _AttendanceIndexPageState extends State<AttendanceIndexPage> {
  var controller = Get.put(AttendanceController());

  Widget buildPage() {
    if (controller.pageFlag.value) {
      return const Center(
        child: RefreshProgressIndicator(),
      );
    } else {
      if (controller.attendances.isNotEmpty) {
        return Provider(
          create: (context) => controller.attendances,
          child: AttendanceCards(reLoadPage: controller.reLoadOnUpdate),
        );
      } else {
        return const Center(
          child: Text("No record found."),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.reloadData,
      child: Column(
        children: [
          HeaderIndex(
            isChildPage: false,
          ),
          AttendanceHeader(),
          Expanded(
            child: buildPage(),
          ),
        ],
      ),
    );
  }
}
