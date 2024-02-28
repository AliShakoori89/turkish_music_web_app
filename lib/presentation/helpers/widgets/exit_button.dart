import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'custom_card.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        FlutterExitApp.exitApp();
      },
      child: const CustomCard(
          title: "Exit",
          customIcon: Icons.exit_to_app,
          customColor: Colors.grey),
    );
  }
}
