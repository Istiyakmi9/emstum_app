import 'package:flutter/material.dart';

class MessageBadge extends StatelessWidget {
  String? msg;
  Color? color;
  MessageBadge({Key? key, this.msg, this.color = Colors.grey }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color!,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        msg!,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
