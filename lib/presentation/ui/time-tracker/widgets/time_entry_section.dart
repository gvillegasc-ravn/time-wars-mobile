import 'package:flutter/material.dart';

class TimeEntrySection extends StatelessWidget {
  const TimeEntrySection({
    super.key,
    required this.name,
    required this.child,
  });

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(name),
          ),
          const SizedBox(width: 5),
          child,
        ],
      ),
    );
  }
}
