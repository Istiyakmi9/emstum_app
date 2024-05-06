import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/attendaceModal.dart';
import 'package:bot_org_manage/screens/attendance/widgets/applyAttendancePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class Attendance extends StatefulWidget {
  final Function reLoadPage;

  const Attendance({Key? key, required this.reLoadPage}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<AttendanceModal> attendances = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List<AttendanceModal> data =
          Provider.of<List<AttendanceModal>>(context, listen: false);

      var leadingIconPrefix = "assets/icons";
      for (var e in data) {
        // debugPrint("Date: ${e.date}, status: ${e.presentDayStatus}");
        switch (e.date.weekday) {
          case 6:
          case 7:
            e.leadingIcon = "$leadingIconPrefix/weekend.png";
            e.isWeekend = true;
            e.color = "#913737";
            e.statusMessage = "OFF";
            e.tralingIcon = "$leadingIconPrefix/giftbox.png";
            break;
          default:
            e.leadingIcon = "$leadingIconPrefix/${e.date.weekday}.png";
            e.tralingIcon = "$leadingIconPrefix/hard-work.png";
            break;
        }

        if (!e.isOpen) {
          e.statusMessage = "Blocked";
          e.color = "#525A88";
          e.cardBorder = Configuration.fail;
        } else if (!e.isWeekend) {
          switch (e.presentDayStatus) {
            case 0:
            case 1:
              e.statusMessage = "OPEN";
              e.color = "#525A88";
              e.cardBorder = Configuration.info;
              break;
            case 2:
              e.statusMessage = "PENDING";
              e.color = "#1A237E";
              e.cardBorder = Configuration.warning;
              break;
            case 3:
              e.statusMessage = "OFF";
              e.color = "#03A9F4";
              e.cardBorder = Configuration.fade;
              break;
            case 4:
              e.statusMessage = "HOLIDAY";
              e.cardBorder = Configuration.info;
              break;
            case 5:
              e.statusMessage = "REJECTED";
              e.cardBorder = Configuration.fail;
              e.color = "#913737";
              break;
            default:
              e.statusMessage = "APPROVED";
              e.cardBorder = Configuration.success;
              e.color = "#2E7D32";
              break;
          }
        }
      }

      setState(() {
        attendances = data.reversed.toList();
      });
    });
  }

  void applyAttendance(AttendanceModal attendance) {
    if (!attendance.isWeekend) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApplyAttendance(attendanceModal: attendance),
        ),
      ).then((value) {
        debugPrint("Pop event completed with value: $value");
        if (value == "APPLIED") {
          widget.reLoadPage(value);
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Weekends are not allowed.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 0,
        bottom: 10,
        left: 4,
        right: 4,
      ),
      child: ListView.builder(
        itemCount: attendances.length,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 6,
        ),
        itemBuilder: (ctx, index) {
          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color:
                    attendances[index].isWeekend ? Colors.white54 : Colors.white,
                // borderRadius: BorderRadius.circular(4),
                border: Border(
                  left: BorderSide(
                    color: Configuration.ColorFromHex(attendances[index].cardBorder),
                    width: 6,
                  )
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 218, 218, 218),
                    blurRadius: 2.0, // soften the shadow
                    spreadRadius: 2.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      2.0, // Move to bottom 10 Vertically
                    ),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  applyAttendance(attendances[index]);
                },
                leading: Image.asset(
                  attendances[index].leadingIcon,
                  width: 40,
                ),
                title: Text(
                  attendances[index].attendanceDay,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Configuration.ColorFromHex(attendances[index].color),
                  ),
                ),
                subtitle:
                    Text(Jiffy(attendances[index].date).format("MMM do, yyyy")),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      attendances[index].tralingIcon,
                      width: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      attendances[index].statusMessage,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
