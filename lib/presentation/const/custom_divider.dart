import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {

  final Color dividerColor;
  const CustomDivider({super.key, required this.dividerColor});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 10,
      color: dividerColor,
      thickness: 0.3,
      indent : 10,
      endIndent : 10,
    );
  }
}
