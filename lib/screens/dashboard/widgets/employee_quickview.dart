import 'package:bot_org_manage/screens/common/container_card/container_card.dart';
import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';

class EmployeeQuickViews extends StatelessWidget {
  Function? changeMenu;

  EmployeeQuickViews({Key? key, required this.changeMenu}) : super(key: key);

  void handleNavigation(ActionCard actionCard, BuildContext context) {
    if (actionCard.isMenuPage) {
      this.changeMenu!(actionCard.menuIndex);
    } else {
      Navigator.pushNamed(context, actionCard.page!,
          arguments: NavigationParams(
            isChildPage: true,
          ));
    }
  }

  Widget getQuickViewCard(ActionCard actionCard, BuildContext context) {
    return InkWell(
      onTap: () {
        handleNavigation(actionCard, context);
      },
      child: SizedBox(
        height: 100,
        child: ContainerCard(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
    return Container(
      height: 280,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: GridView.count(
        primary: false,
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
              menuIndex: Navigate.AttendanceIndex,
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
              menuIndex: Navigate.LeaveIndex,
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
              page: Navigate.myTiming,
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
              page: Navigate.salaryStatement,
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
              page: Navigate.referral,
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
              page: Navigate.filesAndDocuments,
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
