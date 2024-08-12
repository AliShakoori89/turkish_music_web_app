import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/event.dart';
import 'package:turkish_music_app/presentation/ui/main_page.dart';

import '../../bloc/user_bloc/bloc.dart';
import 'custom_card.dart';

class ExitAccountButton extends StatelessWidget {
  const ExitAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit",
          style: TextStyle(
            color: Colors.white
          ),),
          titleTextStyle:
          TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,
          actions: [
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(ExitAccountEvent());
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (route) => false);
                },
                child: Text("Yes")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No")),
          ],
          content: Text("Are you sure?"),
        );
      });},
      child: const CustomCard(
          title: "Exit Account",
          customIcon: Icons.person_off_outlined,
          customColor: Colors.grey),
    );
  }
}
