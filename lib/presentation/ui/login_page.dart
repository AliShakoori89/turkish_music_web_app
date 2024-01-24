import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/const/sign_up_text_button.dart';
import 'package:turkish_music_app/presentation/helpers/custom_button.dart';
import 'package:turkish_music_app/presentation/helpers/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: Image.asset("assets/gif/animation1.gif",
                fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Form(
                        key: emailFormKey,
                        child: CustomTextField(emailController: emailController,)
                    ),
                    const SizedBox(height: 5),
                    SignUpTextButton(emailFormKey: emailFormKey, email: emailController.text),
                  ],
                ),
                CustomButton(emailFormKey: emailFormKey),
              ],
            )

          ),
        ],
      ),
    );
  }
}
