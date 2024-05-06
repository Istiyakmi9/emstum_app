import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';

class EmployeeQuickViews extends StatelessWidget {
  Function? changeMenu;

  EmployeeQuickViews({Key? key, required this.changeMenu}) : super(key: key);

  void handleNavigation(ActionCard actionCard, BuildContext context) {
    if (actionCard.isMenuPage) {
      this.changeMenu!(actionCard.menuIndex);
    } else {
      Navigator.pushNamed(
        context,
        actionCard.page!,
        arguments: NavigationParams(
          isChildPage: true,
        )
      );
    }
  }

  Widget getQuickViewCard(ActionCard actionCard, BuildContext context) {
    return InkWell(
      onTap: () {
        handleNavigation(actionCard, context);
      },
      child: SizedBox(
        height: 100,
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 2,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Icon(
                  actionCard.icon,
                  color: actionCard.textColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        actionCard.titleFirstLine,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        actionCard.titleSecondLine,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          getQuickViewCard(
            ActionCard(
              titleFirstLine: "Time",
              titleSecondLine: "Attendance",
              icon: Icons.calendar_month_sharp,
              textColor: Colors.deepPurple,
              menuIndex: NavigationPage.AttendanceIndex,
              page: null,
              isMenuPage: true,
            ),
            context,
          ),
          getQuickViewCard(
            ActionCard(
              titleFirstLine: "Leave",
              titleSecondLine: "Management",
              icon: Icons.time_to_leave,
              textColor: Colors.green,
              menuIndex: NavigationPage.LeaveIndex,
              page: null,
              isMenuPage: true,
            ),
            context,
          ),
          getQuickViewCard(
            ActionCard(
              titleFirstLine: "Employee",
              titleSecondLine: "Timing",
              icon: Icons.lock_clock_outlined,
              textColor: Colors.blueGrey,
              menuIndex: 0,
              page: NavigationPage.MyTiming,
              isMenuPage: false,
            ),
            context,
          ),
          getQuickViewCard(
            ActionCard(
              titleFirstLine: "Salary",
              titleSecondLine: "Statements",
              icon: Icons.currency_exchange,
              textColor: Colors.red,
              menuIndex: 0,
              page: NavigationPage.SalaryStatement,
              isMenuPage: false,
            ),
            context,
          ),
          getQuickViewCard(
            ActionCard(
              titleFirstLine: "Interview",
              titleSecondLine: "References",
              icon: Icons.person,
              textColor: Colors.deepOrange,
              menuIndex: 0,
              page: NavigationPage.ReferralPage,
              isMenuPage: false,
            ),
            context,
          ),
          getQuickViewCard(
            ActionCard(
              titleFirstLine: "Documents &",
              titleSecondLine: "Evaluation",
              icon: Icons.folder_copy_outlined,
              textColor: Colors.deepOrangeAccent,
              menuIndex: 0,
              page: NavigationPage.FilesAndDocuments,
              isMenuPage: false,
            ),
            context,
          ),
        ],
      ),
    );
  }
}

class ActionCard {
  String titleFirstLine;
  String titleSecondLine;
  IconData icon;
  Color textColor;
  int menuIndex;
  String? page;
  bool isMenuPage;

  ActionCard({
    required this.titleFirstLine,
    required this.titleSecondLine,
    required this.icon,
    required this.textColor,
    required this.page,
    required this.isMenuPage,
    required this.menuIndex,
  });
}
