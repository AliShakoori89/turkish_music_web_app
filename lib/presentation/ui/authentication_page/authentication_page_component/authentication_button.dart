import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import '../../../bloc/user_bloc/bloc.dart';
import '../../../bloc/user_bloc/event.dart';
import '../../main_page/main_page.dart';

class AuthenticationButton extends StatefulWidget {

  final String string;
  final double width;
  final GlobalKey<FormState> emailFormKey;
  int state = 0;

  AuthenticationButton({super.key, required this.string, required this.width, required this.emailFormKey});

  @override
  State<AuthenticationButton> createState() => _AuthenticationButtonState();
}

class _AuthenticationButtonState extends State<AuthenticationButton> {

  final emailController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();

  late List<TextEditingController?> verificationCodeController;
  OtpTimerButtonController controller = OtpTimerButtonController();

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
          onTap: (){

            if (widget.emailFormKey.currentState!.validate()){
              if (widget.state == 0) {
                animateButton();
                final registerBloc = BlocProvider.of<UserBloc>(context);
                if(widget.string == "SIGN UP"){

                  registerBloc.add(RegisterUserEvent(email: emailController.text));

                }
                else if(widget.string == "LOG IN"){

                  registerBloc.add(FirstLoginEvent(email: emailController.text));

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
                                fillColor: Colors.white.withOpacity(.05),
                                borderWidth: 0.25,
                                margin: EdgeInsets.only(
                                    right: 2,
                                    left: 2
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
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

                                  bool isTrue = await registerBloc.userRepository.secondLogin(emailController.text, verificationCode);

                                  if(isTrue){
                                    Fluttertoast.showToast(
                                        msg: "Authentication Success...  WellCome .",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: const Color(
                                            0xFF00B01E).withOpacity(0.2),
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MainPage(),
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Verification code is not true .",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: const Color(
                                            0xFFC20808).withOpacity(0.2),
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                },
                              ),
                              Spacer(),
                              OtpTimerButton(
                                controller: controller,
                                onPressed: () {
                                  controller.startTimer();
                                  registerBloc.add(FirstLoginEvent(email: emailController.text));
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
                }
              }
            }

          },
          child: Container(
            height: size.width / 8,
            width: size.width / widget.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              widget.string,
              style: TextStyle(color: Colors.white.withOpacity(.8)),
            ),
          ),
        ),
      ),
    );
  }
}
