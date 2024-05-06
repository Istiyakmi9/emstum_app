import 'package:bot_org_manage/screens/dashboard/widgets/userinfo.dart';
import 'package:flutter/material.dart';

import '../../utilities/NavigationPage.dart';

class FileAndDocuments extends StatefulWidget {
  const FileAndDocuments({Key? key}) : super(key: key);

  @override
  State<FileAndDocuments> createState() => _FileAndDocumentsState();
}

class _FileAndDocumentsState extends State<FileAndDocuments> {
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
            UserInfo(
              navigationParams: NavigationParams(
                isChildPage: param.isChildPage,
                pageName: "Document & File's",
              ),
            ),
            NavigationPage.GetUnderconstructionPage(),
          ],
        ),
      ),
    );
  }
}