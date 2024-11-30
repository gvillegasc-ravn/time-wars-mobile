import 'package:flutter/material.dart';

class ContainerBorder extends StatelessWidget {
  const ContainerBorder({
    super.key,
    required this.child,
    this.verticalPadding,
    this.horizontalPadding,
  });

  final Widget child;
  final double? verticalPadding;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 5,
        vertical: verticalPadding ?? 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
