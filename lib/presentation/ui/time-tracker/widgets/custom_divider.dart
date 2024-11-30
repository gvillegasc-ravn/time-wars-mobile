import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey.withOpacity(0.5),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
