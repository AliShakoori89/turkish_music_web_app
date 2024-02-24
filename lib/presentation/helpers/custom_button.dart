import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/bloc.dart';
import '../bloc/user_bloc/event.dart';

class CustomButton extends StatefulWidget {
  CustomButton({
    super.key,
    this.emailFormKey,
    required this.buttonName,
    this.email});

  GlobalKey<FormState>? emailFormKey;
  final String buttonName;
  String? email;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with TickerProviderStateMixin{

  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15),
        ),
        onPressed: () {

          setState(() {

            if (widget.emailFormKey!.currentState!.validate()){
              if (_state == 0) {
                animateButton();
                final registerBloc = BlocProvider.of<UserBloc>(context);
                if(widget.buttonName == "Sign Up"){

                  registerBloc.add(RegisterUserEvent(email: widget.email!));

                }
                else if(widget.buttonName == "Sign In"){
                  registerBloc.add(FirstLoginEvent(email: widget.email!));
                }
              }
            }

          });

        },
        child: setUpButtonChild(widget.buttonName),
      ),
    );
  }

  Widget setUpButtonChild(String title) {
    if (_state == 0) {
      return Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    }
    else if (_state == 1) {
      return const SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    else {
      return Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(const Duration(milliseconds: 3300), () {
      setState(() {
        _state = 0;
      });
    });
  }

}