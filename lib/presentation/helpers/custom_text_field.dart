import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05
      ),
      child: TextFormField(
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
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          hintText: 'type your title',
          hintStyle: const TextStyle(
              color: Color.fromRGBO(215, 215, 215, 1)
          ),
          errorStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500),
          filled: true,
        ),
      ),
    );
  }
}


