import 'package:flutter/material.dart';

import 'custom_card.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomCard(
        title: "help",
        customIcon: Icons.help,
        customColor: Colors.grey);
  }
}
