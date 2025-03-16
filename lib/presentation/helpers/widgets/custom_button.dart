import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import '../../bloc/user_bloc/bloc.dart';
import '../../bloc/user_bloc/event.dart';
import '../../ui/main_page/main_page.dart';
import 'custom_toast.dart';

class CustomButton extends StatefulWidget {

  CustomButton({
    super.key,
  required this.buttonTitle,
  required this.width,
  required this.emailFormKey,
  required this.emailController,
  required this.state,
  required this.controller});

  final String buttonTitle;
  final double width;
  final GlobalKey<FormState> emailFormKey;
  final TextEditingController emailController;

  int state;
  OtpTimerButtonController controller;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  late List<TextEditingController?> verificationCodeController;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () async {

            if (widget.emailFormKey.currentState!.validate()){
              if (widget.state == 0) {
                animateButton();
                final registerBloc = BlocProvider.of<UserBloc>(context);
                if(widget.buttonTitle == "SIGN UP"){

                  registerBloc.add(RegisterUserEvent(email: widget.emailController.text));

                }
                else if(widget.buttonTitle == "LOGIN") {

                  String userExist = await registerBloc.userRepository.userExist(widget.emailController.text);

                  if(userExist != "رکورد با مشخصات وارد شده یافت نشد"){

                    registerBloc.add(FirstLoginEvent(email: widget.emailController.text));

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return AlertDialog(
                          title: Container(
                            width: size.width / 1.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Enter Code : '),
                                    IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: Icon(Icons.close))
                                  ],
                                ),
                                Text("Please wait for the code by email ...",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey
                                  ),),
                              ],
                            ),
                          ),
                          content:  Container(
                            // color: Colors.amber,
                            height: size.height / 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                    height: 5),
                                OtpTextField(
                                  numberOfFields: 6,
                                  borderColor: Colors.white,
                                  fillColor: Colors.white.withValues(alpha: 0.5),
                                  borderWidth: 0.25,
                                  margin: EdgeInsets.only(
                                      right: 2,
                                      left: 2
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly, // This allows only digits
                                  ],
                                  focusedBorderColor: const Color(0xffb188ef),
                                  keyboardType: TextInputType.number,
                                  fieldWidth: 35,
                                  filled: true,
                                  showFieldAsBox: true,
                                  handleControllers: (controllers) {
                                    //get all textFields controller, if needed
                                    verificationCodeController = controllers;
                                  },
                                  onSubmit: (String verificationCode) async{

                                    final registerBloc = BlocProvider.of<UserBloc>(context);

                                    bool isTrue = await registerBloc.userRepository.secondLogin(widget.emailController.text, verificationCode);

                                    if(isTrue){

                                      CustomToast(title: "Authentication Success...  Welcome .", toastColor: const Color(
                                          0xFF00B01E).withValues(alpha: 0.2)).show();
                                      // Fluttertoast.showToast(
                                      //     msg: "Authentication Success...  Welcome .",
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.CENTER,
                                      //     timeInSecForIosWeb: 3,
                                      //     backgroundColor: const Color(
                                      //         0xFF00B01E).withValues(alpha: 0.2),
                                      //     textColor: Colors.white,
                                      //     fontSize: 16.0
                                      // );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => MainPage(),
                                        ),
                                      );
                                    } else {

                                      CustomToast(title: "Verification code is not true .", toastColor: const Color(
                                          0xFFC20808).withValues(alpha: 0.2)).show();

                                      // Fluttertoast.showToast(
                                      //     msg: "Verification code is not true .",
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.TOP,
                                      //     timeInSecForIosWeb: 3,
                                      //     backgroundColor: const Color(
                                      //         0xFFC20808).withValues(alpha: 0.2),
                                      //     textColor: Colors.white,
                                      //     fontSize: 16.0
                                      // );
                                    }
                                  },
                                ),
                                Spacer(),
                                OtpTimerButton(
                                  controller: widget.controller,
                                  onPressed: () {
                                    widget.controller.startTimer();
                                    registerBloc.add(FirstLoginEvent(email: widget.emailController.text));
                                  },
                                  text: Text('Resend OTP'),
                                  duration: 120,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );

                  }else{

                    CustomToast(title: "The user has not registered with the entered email .", toastColor: const Color(
                        0xFFC20808).withValues(alpha: 0.2)).show();

                  }

                }
              }
            }

          },
          child: Container(
              height: 40,
              width: size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                widget.buttonTitle,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8),),
              )
          ),
        ),
      ),
    );
  }

  void animateButton() {
    setState(() {
      widget.state = 1;
    });

    Timer(const Duration(milliseconds: 3300), () {
      if (mounted) { // Check if the widget is still mounted before updating the state
        setState(() {
          widget.state = 0;
        });
      }
    });
  }
}
