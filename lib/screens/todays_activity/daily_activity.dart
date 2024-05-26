import 'package:bot_org_manage/screens/common/page_header/header_index.dart';
import 'package:bot_org_manage/screens/common/page_header_info/user_info_detail.dart';
import 'package:flutter/material.dart';

import '../../utilities/NavigationPage.dart';
import '../dashboard/widgets/userinfo.dart';

class DailyActivity extends StatefulWidget {
  const DailyActivity({Key? key}) : super(key: key);

  @override
  State<DailyActivity> createState() => _DailyActivityState();
}

class _DailyActivityState extends State<DailyActivity> {
  bool _flag = false;

  Future<void> _reloadData() async {}

  @override
  Widget build(BuildContext context) {
    final param =
    ModalRoute.of(context)!.settings.arguments as NavigationParams;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _reloadData,
        child: Column(
          children: [
            HeaderIndex(
              isChildPage: false,
            ),
            UserInfoDetail(),
            Navigate.GetUnderconstructionPage(),
          ],
        ),
      ),
    );
  }
}