import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/login_user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/login_user_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/register_user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/register_user_bloc/event.dart';
import '../../bloc/user_bloc/login_user_bloc/event.dart';
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
  bool _isLoading = false;

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
          onTap: _isLoading ? null : () async {

            if (widget.emailFormKey.currentState!.validate()){

              setState(() {
                _isLoading = true;
              });

              if (widget.state == 0) {

                if(widget.buttonTitle == "SIGN UP"){

                  final registerBloc = BlocProvider.of<RegisterUserBloc>(context);

                  registerBloc.add(RegistrationUserEvent(email: widget.emailController.text));

                  CustomToast(title: "Registration Success...  Please login this email .", toastColor: const Color(
                      0xFF00B01E).withValues(alpha: 0.2)).show();

                }
                else if(widget.buttonTitle == "LOGIN") {

                  final loginUserBloc = BlocProvider.of<LoginUserBloc>(context);

                  String userExist = await loginUserBloc.userRepository.userExist(widget.emailController.text);

                  if(userExist != "رکورد با مشخصات وارد شده یافت نشد"){

                    loginUserBloc.add(FirstLoginEvent(email: widget.emailController.text));

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return AlertDialog(
                          title: Container(
                            width: 300,
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
                                SizedBox(
                                  child: OtpTextField(
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

                                      final loginUserBloc = BlocProvider.of<LoginUserBloc>(context);

                                      bool isTrue = await loginUserBloc.userRepository.secondLogin(widget.emailController.text, verificationCode);

                                      if(isTrue){

                                        CustomToast(title: "Authentication Success...  Welcome .", toastColor: const Color(
                                            0xFF00B01E).withValues(alpha: 0.2)).show();

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => MainPage(),
                                          ),
                                        );
                                      } else {

                                        CustomToast(title: "Verification code is not true .", toastColor: const Color(
                                            0xFFC20808).withValues(alpha: 0.2)).show();
                                      }
                                    },
                                  ),
                                ),
                                Spacer(),
                                OtpTimerButton(
                                  controller: widget.controller,
                                  onPressed: () {
                                    widget.controller.startTimer();
                                    loginUserBloc.add(FirstLoginEvent(email: widget.emailController.text));
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

              setState(() {
                _isLoading = false;
              });

            }

          },
          child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.buttonTitle,
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                if (_isLoading) ...[
                  SizedBox(width: 10),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 8,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
