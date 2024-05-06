import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:flutter/material.dart';

import '../../modal/user.dart';
import '../../modal/utils.dart';
import '../../utilities/NavigationPage.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final Util _util = Util();
  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var user = _util.getUserDetail();
      setState(() {
        _user = user;
      });
    });
  }

  Widget createBackgroundCircleRings(
      double c_width, double c_height, Color color) {
    double initialWidth = 300;
    double initialHeight = 300;
    double position_top = -(100 + ((c_width - initialWidth) / 2));
    double position_left = -(100 + (c_height - initialHeight) / 2);

    return Positioned(
      top: position_top,
      left: position_left,
      child: Container(
        width: c_width,
        height: c_height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color, // Background color
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _user == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              createBackgroundCircleRings(
                  600, 600, Configuration.ColorFromHex("#e2f6f2")),
              createBackgroundCircleRings(
                  500, 500, Configuration.ColorFromHex("#cbf3ec")),
              createBackgroundCircleRings(
                  400, 400, Configuration.ColorFromHex("#b7f0e6")),

              // createBackgroundCircleRings(400, 400, Configuration.ColorFromHex("#fff000")),
              ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 10,
                    ),
                    height: Configuration.height * .25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://cdn.britannica.com/89/152989-050-DDF277EA/Johnny-Depp-2011.jpg"),
                            radius: 50,
                            backgroundColor: Colors.white24,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_user!.FirstName}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(21, 26, 74, 1),
                              ),
                            ),
                            Text(
                              "${_user!.Designation == null ? 'No Designation' : _user!.Designation}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      bottom: 40,
                    ),
                    child: Text(
                      "${_user!.Email} (${_user!.EmployeeId})",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Attendance'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.assignment),
                    title: Text('Leave'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notification'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.fact_check_outlined),
                    title: Text('Approval'),
                    onTap: () {
                      // Add your action here for Approval
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        NavigationPage.AttendanceLeaveApproval,
                        arguments: NavigationParams(isChildPage: true),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      // Add your action here for Logout
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
  }
}
