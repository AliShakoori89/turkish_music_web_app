import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key,
  required this.icon,
  required this.hintText,
  required this.isPassword,
  required this.isEmail,
  required this.controller,
  required this.emailFormKey,
  });

  final IconData icon;
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController controller;
  final GlobalKey<FormState> emailFormKey;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          width: 390,
          child: Form(
            key: emailFormKey,
            child: TextFormField(
              controller: controller,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8),),
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
                fillColor: Colors.white.withValues(alpha: 0.1),
                filled: true,
                prefixIcon: Icon(
                  icon,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                border: InputBorder.none,
                hintMaxLines: 1,
                hintText: hintText,
                hintStyle:
                TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
