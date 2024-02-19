import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:turkish_music_app/presentation/helpers/custom_app_bar.dart';
import 'package:turkish_music_app/presentation/helpers/custom_button.dart';

import '../bloc/register_user_bloc/bloc.dart';


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
              child: Container(
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
            Spacer(),
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

                          final registerBloc = BlocProvider.of<RegisterBloc>(context);
                          registerBloc.signUpUserRepository.secondLogin(widget.email, verificationCode);

                          //set clear text to clear text from all fields
                          // setState(() {
                          //   clearText = true;
                          // });
                          // //navigate to different screen code goes here
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       title: Text("Verification Code"),
                          //       content: Text('Code entered is $verificationCode'),
                          //     );
                          //   },
                          // );
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

// BlocBuilder<RegisterBloc, RegisterState>(
//     builder: (context, state){
//
//       String otpCode = state.otpCode;
//
//        return Dialog(
//          child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(
//                      top: 10,
//                      bottom: 20
//                  ),
//                  child: Expanded(
//                    child: Row(
//                      children: [
//                        const Text("Enter code when sent to "),
//                        Text("${email?.substring(0,3)}...${email?.substring(email!.length - 5)} :",
//                            style: const TextStyle(
//                              fontWeight: FontWeight.bold,
//                            )),
//                      ],
//                    ),
//                  ),
//                ),
//                const SizedBox(height: 15),
//                OtpTextField(
//                  numberOfFields: 6,
//                  borderColor: Colors.white,
//                  //set to true to show as box or false to show as dash
//                  showFieldAsBox: true,
//                  //runs when a code is typed in
//                  onCodeChanged: (String code) {
//                    //handle validation or checks here
//                  },
//                  //runs when every textfield is filled
//                  onSubmit: (String verificationCode){
//                    showDialog(
//                        context: context,
//                        builder: (context){
//                          return AlertDialog(
//                            title: const Text("Verification Code",
//                              style: TextStyle(color: Colors.white),),
//                            content: Text('Code entered is $verificationCode'),
//                          );
//                        }
//                    );
//                  }, // end onSubmit
//                ),
//                const SizedBox(height: 20),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    TextButton(
//                      onPressed: () {
//                        registerBloc.add(
//                            RegisterUserViaOTPCodeEvent(email: email!, otpCode: otpCode));
//                        Navigator.pop(context);
//                      },
//                      child: const Text('Submit'),
//                    ),
//                    TextButton(
//                      onPressed: () {
//                        Navigator.pop(context);
//                      },
//                      child: const Text('Close'),
//                    ),
//                  ],
//                ),
//              ],
//            ),
//          ),
//        );
//     },
// );