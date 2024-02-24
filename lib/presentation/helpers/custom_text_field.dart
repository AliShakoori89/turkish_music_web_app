import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Email"),
      cursorColor: Colors.grey,
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter email';
        }
        else if (EmailValidator.validate(value)){
          return null ;
        }
        return "Enter a valid email";
      },
      autocorrect: false,
    );
  }
}


