import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Color backgroundColor;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const CustomContainer({
    super.key,
    required this.backgroundColor,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
