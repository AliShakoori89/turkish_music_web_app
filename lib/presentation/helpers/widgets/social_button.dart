import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: Container(
          height: context.height * 0.05,
          width: context.height * 0.05,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/auth_assets/gmail_icon.png"),
            fit: BoxFit.cover,
          )),
        ));
  }
}
