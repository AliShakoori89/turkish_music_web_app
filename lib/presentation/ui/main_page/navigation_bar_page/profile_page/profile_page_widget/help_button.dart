import 'package:flutter/material.dart';

import '../../../../../helpers/widgets/custom_card.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomCard(
        title: "Help",
        customIcon: Icons.help_center_outlined,
        customColor: Colors.grey);
  }
}
