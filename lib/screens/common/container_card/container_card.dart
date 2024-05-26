import 'package:flutter/material.dart';

class ContainerCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const ContainerCard({
    super.key,
    required this.child,
    this.margin,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }
}
