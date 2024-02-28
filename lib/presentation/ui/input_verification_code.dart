import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../bloc/user_bloc/bloc.dart';
import 'main_page/main_page.dart';

class InputVerificationCode extends StatefulWidget {
  const InputVerificationCode({super.key,
    required this.email});

  final String email;

  @override
  State<InputVerificationCode> createState() => _InputVerificationCodeState();
}

class _InputVerificationCodeState extends State<InputVerificationCode> {

  late List<TextEditingController?> verificationCodeController;
  bool clearText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Text("Verification Page",
                    style: TextStyle(
                      color: Colors.white
                    ),),

                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.08,
                left: MediaQuery.of(context).size.width * 0.08
              ),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Input verification code :",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                      OtpTextField(
                        numberOfFields: 6,
                        borderColor: Colors.white,
                        showFieldAsBox: true,
                        handleControllers: (controllers) {
                          //get all textFields controller, if needed
                          verificationCodeController = controllers;
                        },
                        onSubmit: (String verificationCode) {

                          final registerBloc = BlocProvider.of<UserBloc>(context);

                          registerBloc.signUpUserRepository.secondLogin(widget.email, verificationCode);

                          Get.to(const MainPage());

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.4,)
          ],
        ),
      ),
    );
  }
}