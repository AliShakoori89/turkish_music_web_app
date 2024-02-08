import 'package:flutter/material.dart';
import 'custom_card.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomCard(
        title: "report",
        customIcon: Icons.report,
        customColor: Colors.grey);
  }
}