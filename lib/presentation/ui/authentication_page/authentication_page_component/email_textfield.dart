import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

Widget component1(
    IconData icon, String hintText, bool isPassword, bool isEmail,
    TextEditingController controller, GlobalKey<FormState> emailFormKey) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaY: 15,
        sigmaX: 15,
      ),
      child: Container(

        child: Form(
          key: emailFormKey,
          child: TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.6),),
            cursorColor: Colors.white,
            obscureText: isPassword,
            keyboardType:
            isEmail ? TextInputType.emailAddress : TextInputType.text,
            textAlignVertical: TextAlignVertical.center,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter email';
              }
              else if (EmailValidator.validate(value)){
                return null ;
              }
              return "Enter a valid email";
            },
            decoration: InputDecoration(
              fillColor: Colors.white.withValues(alpha: 0.5),
              filled: true,
              prefixIcon: Icon(
                icon,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
              TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.5),),
            ),
          ),
        ),
      ),
    ),
  );
}