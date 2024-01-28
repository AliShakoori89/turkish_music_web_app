import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(
          5
      ),
      child: Divider(
        color: Colors.grey,
        thickness: 0.1,
      ),
    );
  }
}
