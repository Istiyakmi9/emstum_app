import 'package:bot_org_manage/utilities/constants.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String label;
  final Function action;
  final Color color;
  final bool isSubmitted;
  Color labelColor = Colors.white;
  String loadingLabel = Constants.Empty;

  Buttons({
    Key? key,
    required this.label,
    required this.action,
    required this.color,
    required this.isSubmitted,
    this.loadingLabel = "Please wait",
    this.labelColor = Colors.white,
  }) : super(key: key);

  void _submit() {
    action("user data");
  }

  Widget customButton() {
    return MaterialButton(
      onPressed: _submit,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: Text(
              label,
              style: TextStyle(
                color: labelColor,
              ),
            ),
          ),
          Visibility(
            visible: isSubmitted,
            child: const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return customButton();
  }
}
