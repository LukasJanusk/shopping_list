import 'package:flutter/material.dart';

class DividerWithTitle extends StatelessWidget {
  const DividerWithTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ).copyWith(color: Colors.black),
        ),
        SizedBox(width: 16),
        Expanded(child: Divider()),
      ],
    );
  }
}
