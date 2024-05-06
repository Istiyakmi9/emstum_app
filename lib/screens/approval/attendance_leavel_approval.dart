import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/approvalModel.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utilities/NavigationPage.dart';
import '../../widgets/badge.dart';
import '../dashboard/widgets/userinfo.dart';

class AttendanceLeaveApproval extends StatefulWidget {
  const AttendanceLeaveApproval({Key? key}) : super(key: key);

  @override
  State<AttendanceLeaveApproval> createState() =>
      _AttendanceLeaveApprovalState();
}

class _AttendanceLeaveApprovalState extends State<AttendanceLeaveApproval> {
  bool _pageReadyFlag = false;
  List<bool> _selections = [];
  NavigationParams? _arguments;
  List<ApprovalModel> _approvalAttendances = <ApprovalModel>[];
  Ajax _ajax = Ajax.getInstance();
  Util _util = Util();
  User? _user;
  bool dismissed = false;
  bool _isRequestPending = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selections = List.generate(3, (_) => false);
    _selections[0] = true;
    setState(() {
      _selections = _selections;
      _pageReadyFlag = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final param =
          ModalRoute.of(context)!.settings.arguments as NavigationParams;
      setState(() {
        _user = _util.getUserDetail();
      });

      // write your logic here
      await getPageData();
    });
  }

  Widget _filterHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToggleButtons(
            isSelected: _selections,
            onPressed: (index) {
              var items = List.generate(3, (_) => false);
              items[index] = !items[index];
              setState(() {
                _selections = items;
                _pageReadyFlag = false;
              });

              SchedulerBinding.instance.addPostFrameCallback((_) {
                getPageData();
              });
            },
            fillColor: Colors.orangeAccent,
            borderColor: Colors.lightBlueAccent,
            selectedBorderColor: Colors.red,
            color: Colors.black,
            selectedColor: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text("Pending"),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text("Approved"),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text("Rejected"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getPageData() async {
    debugPrint("Starting api call");
    var response =
        await _ajax.post("AttendanceRequest/GetAttendenceRequestData", {
      "EmployeeId": 0,
      "ForMonth": DateTime.now().month,
      "ForYear": DateTime.now().year,
      "PageIndex": 1,
      "ReportingManagerId": _user!.EmployeeId,
      "PresentDayStatus": _selections[0]
          ? 2
          : _selections[1]
              ? 9
              : 5,
      "TotalDays": 0
    });

    buildAttendancePage(response);
  }

  void buildAttendancePage(dynamic response) {
    _approvalAttendances = [];
    if (response != null && response != "") {
      var attendanceRequest = response["FilteredAttendance"];
      if (attendanceRequest != null) {
        for (var attendance in attendanceRequest) {
          _approvalAttendances.add(ApprovalModel.fromJson(attendance));
        }
      } else {
        Fluttertoast.showToast(msg: "Fail to get attendance request data");
      }
    }

    setState(() {
      _pageReadyFlag = true;
      _isRequestPending = false;
      _approvalAttendances = _approvalAttendances;
    });
  }

  Color getCardStatusColor(int statusCode) {
    Color color = Colors.blue;
    switch (statusCode) {
      case 9:
        color = Colors.green;
        break;
      case 5:
        color = Colors.red;
        break;
    }

    return color;
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Reject",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
            ),
            Text(
              " Approve",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Future<bool> confirmApprove(DismissDirection direction, int index) async {
    bool flag = false;
    if (direction == DismissDirection.startToEnd) {
      flag = true;
    }

    bool status = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: Builder(
            builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              return Container(
                height: Configuration.height * .16,
                width: Configuration.width - 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://cdn.britannica.com/89/152989-050-DDF277EA/Johnny-Depp-2011.jpg"),
                              radius: 50,
                              backgroundColor: Colors.white24,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _approvalAttendances[index].EmployeeName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  _approvalAttendances[index].Day,
                                ),
                                Text(
                                  _approvalAttendances[index].AttendanceDate,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                        "Message: ${_approvalAttendances[index].UserComments}"),
                    SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      children: [
                        Text("To approve, press "),
                        Text(
                          flag ? "Approve button" : "Reject button",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton.icon(
              label: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              icon: Icon(
                Icons.cancel,
                color: Theme.of(context).colorScheme.primary,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.onPrimary),
              ),
              onPressed: () {
                status = false;
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton.icon(
              label: Text(
                flag ? "Approve" : "Reject",
                style: TextStyle(color: Colors.white),
              ),
              icon: _isRequestPending
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              onPressed: () async {
                // TODO: Delete the item from DB etc..
                status = false;
                setState(() {
                  _isRequestPending = true;
                });
                await approveOrReject(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return status;
  }

  Future<void> approveOrReject(int index) async {
    ApprovalModel model = _approvalAttendances[index];
    model.EmployeeId = 0;
    dynamic approvalModel = ApprovalModel.toJson(model);
    final response = await _ajax.put(
        "AttendanceRequest/ApproveAttendanceRequest/0", approvalModel);
    if (response != null) {
      buildAttendancePage(response);
    } else {
      Fluttertoast.showToast(msg: "Fail to perform action.");
    }
  }

  Widget getPageContent() {
    return Row(
      children: [
        dismissed
            ? Container()
            : Expanded(
                child: ListView.builder(
                  itemCount: _approvalAttendances.length,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 6,
                  ),
                  itemBuilder: (ctx, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: slideRightBackground(),
                      secondaryBackground: slideLeftBackground(),
                      confirmDismiss: (direction) {
                        return confirmApprove(direction, index);
                      },
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(4),
                            border: Border(
                                left: BorderSide(
                              color: getCardStatusColor(
                                  _approvalAttendances[index].PresentDayStatus),
                              width: 6,
                            )),
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
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "https://cdn.britannica.com/89/152989-050-DDF277EA/Johnny-Depp-2011.jpg"),
                                          radius: 50,
                                          backgroundColor: Colors.white24,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _approvalAttendances[index]
                                                  .EmployeeName,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Wrap(
                                              children: [
                                                Text(
                                                  _approvalAttendances[index]
                                                      .Day,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: const Text("|"),
                                                ),
                                                Text(
                                                  _approvalAttendances[index]
                                                      .AttendanceDate,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Column(
                                    children: [
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          MessageBadge(
                                            msg: _approvalAttendances[index]
                                                        .SessionType ==
                                                    1
                                                ? "Full day"
                                                : "Half day",
                                            color: Colors.cyan,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: const Text("|"),
                                          ),
                                          Text(
                                            "Pending",
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: const Text("|"),
                                          ),
                                          Text(
                                            _approvalAttendances[index]
                                                        .WorkTypeId ==
                                                    1
                                                ? "Work from home"
                                                : "Work from office",
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Comments:  ${_approvalAttendances[index].UserComments}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.blueGrey,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context)!.settings.arguments as NavigationParams;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getPageData,
        child: Column(
          children: [
            UserInfo(
              navigationParams: NavigationParams(
                isChildPage: _arguments!.isChildPage,
                pageName: "Approval Request",
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: _filterHeader(),
            ),
            _pageReadyFlag
                ? Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 0,
                        bottom: 10,
                      ),
                      child: (_approvalAttendances.length > 0 && _pageReadyFlag)
                          ? getPageContent()
                          : Container(
                              margin: EdgeInsets.only(
                                top: 50,
                              ),
                              child: Text(
                                "No record found",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      top: 100,
                    ),
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
