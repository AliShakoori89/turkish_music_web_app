import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20)
      ),
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.grey.withOpacity(0.4)),
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
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          hintText: "Please sign in your email...",
          prefixIcon: const Icon(Icons.email),
          hintStyle: (const TextStyle(color: Colors.white30,
          fontWeight: FontWeight.w400)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              )),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              )),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
      ),
    );
  }
}
