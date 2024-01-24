import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.emailFormKey});

  final GlobalKey<FormState> emailFormKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white30,
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15),
        ),
        onPressed: () {
          if (emailFormKey.currentState!.validate()) {

          }
        },
        child: const Text('Sign in',
          style: TextStyle(
              color: Colors.white
          ),),
      ),
    );
  }
}
