import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {

  final String title;
  final bool haveSeeAll;
  const TitleText({super.key, required this.title, required this.haveSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontFamily: 'Salsa'
            )),
        haveSeeAll == true
            ? const Text(
            "see all >>")
            : const Text("")
      ],
    );
  }
}
