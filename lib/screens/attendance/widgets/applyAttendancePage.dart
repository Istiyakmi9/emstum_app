import 'package:bot_org_manage/modal/Configuration.dart';
import 'package:bot_org_manage/modal/attendaceModal.dart';
import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/screens/attendance/widgets/attendanceDetail.dart';
import 'package:bot_org_manage/screens/attendance/widgets/employeeDetail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'applyingModal.dart';

class ApplyAttendance extends StatefulWidget {
  AttendanceModal attendanceModal;

  ApplyAttendance({super.key, required this.attendanceModal});

  @override
  State<ApplyAttendance> createState() => _ApplyAttendanceState();
}

class _ApplyAttendanceState extends State<ApplyAttendance> {
  final List<bool> _selectedFruits = <bool>[true, false];
  late AttendanceModal _attendanceModal;
  final TextEditingController msgController = TextEditingController();
  User user = User();
  bool _isFreshApplying = false;
  String _status = "";
  String _userMessage = "";
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isSubmitted = false;
      _attendanceModal = widget.attendanceModal;
      _status = _attendanceModal.statusMessage;
      _userMessage = _attendanceModal.userComments;
      _isFreshApplying = (_attendanceModal.presentDayStatus == 1 ||
              _attendanceModal.presentDayStatus == 0)
          ? true
          : false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _applyNow() {
    debugPrint(msgController.text);
    _attendanceModal.employeeId = user.UserId;
    _attendanceModal.userTypeId = user.UserTypeId;
    showDialog(
      context: context,
      builder: (_) => ApplyingModal(
        attendanceModal: _attendanceModal,
        comments: msgController.text,
        callback: (bool flag) {
          setState(() {
            _isFreshApplying = flag;
            _isSubmitted = false;
            _status = "APPLIED";
          });
        }
      ),
    );
  }

  Widget _applyNowWidget() {
    msgController.text = _userMessage;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          AttendanceDetail(attendanceModal: _attendanceModal),
          const SizedBox(
            height: 30,
          ),
          // halfOrFullDayWidget(),
          EmployeeDetail(attendanceModal: _attendanceModal),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 5,
            ),
            alignment: Alignment.centerLeft,
            child: const Text("Your comments"),
          ),
          TextField(
            enabled: _isFreshApplying,
            enableInteractiveSelection: false,
            minLines: 4,
            maxLines: 10,
            keyboardType: TextInputType.text,
            controller: msgController,
            decoration: InputDecoration(
              filled: !_isFreshApplying,
              fillColor: Configuration.ColorFromHex("#d0dbd3"),
              hintText: 'description',
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            child: _isFreshApplying
                ? ElevatedButton(
                    onPressed: () {
                      if (msgController.text.trim().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Comment is a required field");
                      } else {
                        _applyNow();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.subdirectory_arrow_right_sharp),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Apply Now"),
                          ],
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      const Text("Already applied for the present day."),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Status"),
                      Text(
                        _status,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Apply attendance",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop(_status);
          },
        ),
      ),
      body: _applyNowWidget(),
    );
  }
}
