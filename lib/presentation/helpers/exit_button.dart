import 'package:flutter/material.dart';

import 'custom_card.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomCard(
        title: "Exit",
        customIcon: Icons.exit_to_app,
        customColor: Colors.grey);
  }
}
