import 'package:flutter/material.dart';

import 'custom_card.dart';

class ExitAccountButton extends StatelessWidget {
  const ExitAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      },
      child: const CustomCard(
          title: "Exit Account",
          customIcon: Icons.person_off_outlined,
          customColor: Colors.grey),
    );
  }
}
