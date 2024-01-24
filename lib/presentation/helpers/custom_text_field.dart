import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        cursorColor: Colors.grey,
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter email';
          }
          else if (EmailValidator.validate(value)){
            return null ;
          }
          return "Please enter a valid email";
        },
        autocorrect: false,
        decoration: const InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          hintText: "Please sign in your email...",
          hintStyle: (TextStyle(color: Colors.white30)),
          icon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              )),
        ),
      ),
    );
  }
}
