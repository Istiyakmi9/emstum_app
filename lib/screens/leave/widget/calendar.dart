import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/LeaveTypeBrief.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final presentDate = DateTime.now();
  List<bool> _selections = [];
  LeaveTypeBrief? _selectedLeave;
  List<LeaveTypeBrief> _brief = [];
  final _formKey = GlobalKey<FormState>();
  final _ajax = Ajax.getInstance();
  final _messageController = TextEditingController();
  int _daysApplyingFor = 0;
  DateTime _firstDate = DateTime.now();
  DateTime _secondDate = DateTime.now();
  String? _message;
  int _leaveType = 0;
  bool _flag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selections = List.generate(3, (_) => false);
    _selections[0] = true;

    var briefList = <LeaveTypeBrief>[];
    if (briefList.isEmpty) {
      briefList.add(LeaveTypeBrief.fromLeaveTypeBrief(
        1,
        "Not found",
        0,
        0,
        false,
        false,
        false,
        0,
      ));

      setState(() {
        _selections = _selections;
        _selectedLeave = briefList[0];
        _brief = briefList;
        _daysApplyingFor = 1;
        _firstDate = _firstDate;
        _secondDate = _firstDate;
        _message = '';
        _leaveType = 1;
        _flag = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final brief =
            ModalRoute.of(context)!.settings.arguments as List<LeaveTypeBrief>;

        if (brief.isNotEmpty) {
          setState(() {
            _brief = brief;
            _selectedLeave = brief[0];
          });
        }
      });
    }
  }

  Future<void> _submitLeaveRequest() async {
    // Navigator.pop(context);
    setState(() {
      _flag = true;
    });

    if (_selectedLeave == null) {
      Fluttertoast.showToast(msg: "Leave type is required");
      return;
    }

    // ignore: unrelated_type_equality_checks
    if (_selectedLeave!.isCommentsRequired && _messageController.text == "") {
      Fluttertoast.showToast(msg: "Comment is required");
      return;
    }

    if (_daysApplyingFor < 0) {
      Fluttertoast.showToast(msg: "Invalid date selected");
      return;
    }

    var user = Util().getUserDetail();
    _ajax.upload("Leave/ApplyLeave", null, {
      "LeaveFromDay": Ajax.convertToServerDateTime(_firstDate),
      "LeaveToDay": Ajax.convertToServerDateTime(_secondDate),
      "Session": _leaveType + 1,
      "Reason": _messageController.text,
      "RequestType": _leaveType + 1,
      "IsProjectedFutureDateAllowed": false,
      "LeaveTypeId": _selectedLeave!.leavePlanTypeId,
      "UserTypeId": 2,
      "EmployeeId": user.EmployeeId,
      "LeavePlanName": _selectedLeave!.leavePlanTypeName,
      "AssigneId": 5,
      "AssigneeEmail": "istiyaq.mi9@gmail.com"
    }).then((response) {
      if (response != null) {
        Fluttertoast.showToast(msg: "Leave applied successfully");
        Navigator.pop(context, response);
      } else {
        Fluttertoast.showToast(msg: "Fail to apply leave, contact to admin");
      }

      setState(() {
        _flag = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Apply leave",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: Configuration.height * .4,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              child: ScrollableCleanCalendar(
                calendarController: CleanCalendarController(
                  minDate: DateTime.now().subtract(
                    const Duration(days: 30),
                  ),
                  maxDate: DateTime.now().add(
                    Duration(
                      days: DateTime(DateTime.now().year, 12, 31)
                          .difference(DateTime.now())
                          .inDays,
                    ),
                  ),
                  onRangeSelected: (firstDate, secondDate) {
                    debugPrint(
                        "1st date: $firstDate and 2nd date: $secondDate");
                    if (secondDate != null) {
                      var totalDays = secondDate.difference(firstDate).inDays;
                      setState(() {
                        _daysApplyingFor = totalDays;
                        _firstDate = firstDate;
                        _secondDate = secondDate;
                      });
                    }
                  },
                  onDayTapped: (date) {
                    debugPrint("Day tapped: $date");
                  },
                  // readOnly: true,
                  onPreviousMinDateTapped: (date) {
                    debugPrint("Previous min date tapped: $date");
                  },
                  onAfterMaxDateTapped: (date) {
                    debugPrint("After max date tapped: $date");
                  },
                  weekdayStart: DateTime.monday,
                  initialFocusDate: _firstDate,
                  initialDateSelected: _firstDate,
                  endDateSelected: _secondDate,
                ),
                layout: Layout.BEAUTY,
                calendarCrossAxisSpacing: 0,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  (_brief.isEmpty && _selectedLeave != null)
                      ? const Text("Not available")
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Configuration.width * .6,
                              padding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  // dropdownColor: Colors.white,
                                  value: _selectedLeave!.leavePlanTypeId
                                      .toString(),
                                  onChanged: (value) {
                                    debugPrint(value);
                                    var index = _brief.indexWhere((x) =>
                                        x.leavePlanTypeId.toString() == value);

                                    if (index != -1) {
                                      setState(() {
                                        _selectedLeave = _brief[index];
                                      });
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Invalid value selected");
                                    }
                                  },
                                  items: _brief
                                      .map<DropdownMenuItem<String>>(
                                          (LeaveTypeBrief value) =>
                                              DropdownMenuItem<String>(
                                                value: value.leavePlanTypeId
                                                    .toString(),
                                                child: SizedBox(
                                                  child: Text(
                                                    "${value.leavePlanTypeName}  ${value.availableLeaves} (/${value.totalLeaveQuota})",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ))
                                      .toList(),

                                  // add extra sugar..
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 36,
                                  underline: const SizedBox(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const Text("Not found"),
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ToggleButtons(
                        isSelected: _selections,
                        constraints: BoxConstraints(
                          minWidth: (Configuration.width * .5) / 3,
                          maxHeight: (Configuration.width * .1),
                          minHeight: (Configuration.width * .1),
                        ),
                        onPressed: (index) {
                          var items = List.generate(3, (_) => false);
                          DateTime date = Jiffy(DateTime.now())
                              .subtract(months: index)
                              .dateTime;
                          items[index] = !items[index];
                          setState(() {
                            _selections = items;
                            _leaveType = index;
                          });

                          // SchedulerBinding.instance.addPostFrameCallback((_) {
                          // });
                        },
                        fillColor: Colors.orangeAccent,
                        borderColor: Colors.lightBlueAccent,
                        selectedBorderColor: Colors.red,
                        color: Colors.black,
                        selectedColor: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        children: const [
                          Text(
                            "Full",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "1st Half",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "2nd Half",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text("$_daysApplyingFor day(s)"),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    minLines: 4,
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Enter your reason',
                      // Set border for enabled state (default)
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // Set border for focused state
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitLeaveRequest();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _flag
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.add_task),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Apply"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: const [
                      Text(
                        "Note: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Double tap on date to select single day"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
