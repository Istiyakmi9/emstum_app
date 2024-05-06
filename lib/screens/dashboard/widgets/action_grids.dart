import 'package:bot_org_manage/utilities/NavigationPage.dart';
import 'package:flutter/material.dart';

import '../../../modal/Configuration.dart';

class ActionGrids extends StatelessWidget {
  final cardHeight = Configuration.width * 0.3;
  final cardWidth = Configuration.width * 0.3;

  ActionGrids({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 10,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "What's up Today ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, NavigationPage.DailyActivity,
                        arguments: NavigationParams(
                          isChildPage: true,
                        ));
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.red,
                    width: 4,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Daily team statistics",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "View your team activity",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          NavigationPage.DailyActivity,
                          arguments: NavigationParams(
                            isChildPage: true,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.green,
                    width: 4,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Meeting notification and Actions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Ohh!!! you don't have any",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          NavigationPage.DailyActivity,
                          arguments: NavigationParams(
                            isChildPage: true,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
