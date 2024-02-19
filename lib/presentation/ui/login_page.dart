import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/helpers/custom_button.dart';
import 'package:turkish_music_app/presentation/helpers/custom_text_field.dart';
import '../bloc/register_user_bloc/bloc.dart';
import '../bloc/register_user_bloc/state.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50
          ),
          child: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/logo/tMusic.png"),)
                        ),
                      ),
                  ),
                ),
                Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 50
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
