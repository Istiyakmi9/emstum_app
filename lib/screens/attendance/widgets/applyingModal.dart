import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';

import '../../../modal/attendaceModal.dart';
import '../../../service/ajax.dart';
import '../../../widgets/alertModals.dart';

class ApplyingModal extends StatefulWidget {
  final AttendanceModal attendanceModal;
  final String comments;
  final Function callback;

  const ApplyingModal({
    Key? key,
    required this.attendanceModal,
    required this.comments,
    required this.callback,
  }) : super(key: key);

  @override
  State<ApplyingModal> createState() => _ApplyingModalState();
}

class _ApplyingModalState extends State<ApplyingModal> {
  late AttendanceModal _attendanceModal;
  bool _isSubmitted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _attendanceModal = widget.attendanceModal;
      _isSubmitted = false;
    });
  }

  void _applyNow() {
    setState(() {
      _isSubmitted = true;
    });

    Ajax ajax = Ajax.getInstance();
    ajax.post("Attendance/SubmitAttendance", {
      "AttendenceDetailId": _attendanceModal.attendenceDetailId,
      "AttendanceId": _attendanceModal.attendanceId,
      "AttendanceDay": Ajax.convertToServerDateTime(_attendanceModal.date),
      "AttendenceFromDay": Ajax.convertToServerDateTime(_attendanceModal.date),
      "AttendenceToDay": Ajax.convertToServerDateTime(_attendanceModal.date),
      "EmployeeUid": _attendanceModal.employeeId,
      "UserComments": widget.comments,
      "UserTypeId": _attendanceModal.userTypeId,
    }).then((value) {
      bool flag = true;
      if (value != null) {
        flag = false;
        Fluttertoast.showToast(msg: "Attendance applied successfully");
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: "Fail to apply. Please contact to admin");
      }

      widget.callback(flag);
      // Navigator.pop(context);
    }).catchError((e) {
      setState(() {
        _isSubmitted = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertModal(
      title: "Confirm your request",
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          padding: const EdgeInsets.all(0),
          child: const Text(
            "Close",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _applyNow();
          },
          child: Column(
            children: [
              _isSubmitted
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Please wait ..."),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.subdirectory_arrow_right_sharp),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Apply"),
                      ],
                    )
            ],
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Please check your detail below and press to Apply to confirm",
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "Message: ",
              ),
              Text(
                "[${widget.comments}]",
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              const Text(
                "Date: ",
              ),
              Text(
                Jiffy(_attendanceModal.date).format("do MMM, yyyy"),
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
