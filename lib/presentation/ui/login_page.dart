import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_text_field.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/app_logo.dart';

import '../helpers/widgets/custom_button.dart';

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

      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/backgroundApp.jpg"),
                    fit: BoxFit.cover
                  )
              ),
              child: Container(
                  margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: MediaQuery.of(context).size.height * 0.55
                  ),
                  child: Column(
                    children: [
                      Form(
                          key: emailFormKey,
                          child: CustomTextField(emailController: emailController,)
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Column(
                        children: [
                          CustomButton(
                              emailFormKey: emailFormKey,
                              buttonName: "Sign Up",
                              email: emailController.text),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.008,
                          ),
                          CustomButton(
                              emailFormKey: emailFormKey,
                              buttonName: "Sign In",
                              email: emailController.text),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.008,
                          ),
                          CustomButton(
                              emailFormKey: emailFormKey,
                              buttonName: "Sign in with google"),
                        ],
                      )
                    ],
                  )
              ),
            ),
            AppLogo(),
          ],
        ),
      )
    );
  }
}