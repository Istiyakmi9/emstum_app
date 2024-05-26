import 'package:bot_org_manage/screens/home_layout/widgets/drawer_menu.dart';
import 'package:bot_org_manage/screens/home_layout/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        Fluttertoast.showToast(
            msg: "Please close you application if you want to exit.");
        Future.value(false);
      },
      child: Obx(
        () => Scaffold(
          // appBar: PageAppBar(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.pageIndex.value,
            selectedItemColor: Colors.black87,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            onTap: controller.loadPageOnTap,
            items: controller.getMenuItems(),
            type: BottomNavigationBarType.fixed,
          ),
          drawer: Drawer(
            child: DrawerMenu(),
          ),
          body: controller.getWidgetByIndex(controller.pageIndex.value),
        ),
      ),
    );
  }
}
