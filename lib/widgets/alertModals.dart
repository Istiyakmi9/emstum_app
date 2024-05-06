import 'package:flutter/material.dart';

class AlertModal extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const AlertModal(
      {Key? key,
      required this.title,
      required this.content,
      required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary
        ),
      ),
      actions: actions,
      content: content,
    );
  }
}
