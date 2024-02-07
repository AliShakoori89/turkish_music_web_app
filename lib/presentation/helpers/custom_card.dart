import 'package:flutter/material.dart';

import '../const/custom_divider.dart';

class CustomCard extends StatelessWidget {

  final String title;
  final IconData customIcon;
  final Color customColor;

  const CustomCard({super.key,
    required this.title,
    required this.customIcon,
    required this.customColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10,
                  left: 8,
                  right: 8,
                  bottom: 10
              ),
              child: Row(
                children: [
                  Icon(customIcon),
                  const SizedBox(width: 10),
                  Text(title),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
              size: 20,)
          ],
        ),
        CustomDivider(
            dividerColor : customColor
        ),
      ],
    );
  }
}
