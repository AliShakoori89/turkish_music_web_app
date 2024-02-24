import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/constants.dart';
import '../custom_text_field.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key,
    this.emailFormKey,
    this.email});

  GlobalKey<FormState>? emailFormKey;
  String? email;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.13),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Form(
                key: emailFormKey,
                child: CustomTextField(emailController: emailController)
            ),
            const Spacer(flex: 1)
          ],
        ),
      ),
    );
  }
}
