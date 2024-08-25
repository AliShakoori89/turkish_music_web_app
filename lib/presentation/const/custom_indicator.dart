import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/custom_icons/loading_play.gif",
        height: 125.0,
        width: 125.0,
      ),
    );
  }
}
