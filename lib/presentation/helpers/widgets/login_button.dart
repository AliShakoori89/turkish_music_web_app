import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/login_user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/login_user_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/login_user_exist_bloc/login_user_state.dart';
import '../../bloc/user_bloc/login_user_bloc/event.dart';
import '../../bloc/user_bloc/login_user_exist_bloc/login_user_bloc.dart';
import '../../bloc/user_bloc/login_user_exist_bloc/login_user_event.dart';
import '../../ui/main_page/main_page.dart';
import 'custom_toast.dart';

class LoginButton extends StatefulWidget {

  LoginButton({
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
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  late List<TextEditingController?> verificationCodeController;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    return BlocListener<LoginUserBloc, LoginUserState>(
      listener: (context, state){

        if (state.status.isLoading) {
          Center(child: CircularProgressIndicator());
        }else if (state.status.isSuccess) {
          if (state.firstRegisterStatus) {

            WebToast(
              title: 'Sent code to your email successfully.',
              backgroundColor: Color(0xFF00B01E),
              icon: Icons.check_circle,
            ).show(context);

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return AlertDialog(
                      title: SizedBox(
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
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                            const Text(
                              "Please check your email and enter the code",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      content: BlocListener<LoginUserBloc, LoginUserState>(
                        listener: (context, state){

                          if (state.status.isLoading) {
                            Center(child: CircularProgressIndicator());
                          }else if (state.status.isSuccess) {
                            if (state.secondRegisterStatus) {
                              WebToast(
                              title: "Authentication Success...  Welcome .",
                              backgroundColor: Color(0xFF00B01E),
                              icon: Icons.check_circle,
                              ).show(context);

                              Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => MainPage()),
                              );
                            }else{
                              WebToast(
                              title: "Verification code is not true .",
                              backgroundColor: Color(0xFFC20808),
                              icon: Icons.check_circle,
                              ).show(context);
                            }
                          }else if (state.status.isError) {

                            }
                          },
                          child:  SizedBox(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Spacer(),
                                PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  obscureText: false,
                                  animationType: AnimationType.fade,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  autoFocus: true,
                                  textStyle: const TextStyle(
                                    color: Colors.black, // 👈 این خط رنگ اعداد رو مشکی می‌کنه
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 40,
                                    fieldWidth: 35,
                                    activeColor: const Color(0xffb188ef),
                                    selectedColor: Colors.white,
                                    inactiveColor: Colors.white.withOpacity(0.5),
                                    activeFillColor: Colors.white,
                                    selectedFillColor: Colors.white,
                                    inactiveFillColor: Colors.white.withOpacity(0.5),
                                  ),
                                  animationDuration: const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  onCompleted: (String verificationCode) async {

                                    context.read<LoginUserBloc>().add(
                                        SecondLoginEvent(email: widget.emailController.text, verificationToken: verificationCode)
                                    );

                                  },
                                  onChanged: (value) {
                                    // Optional
                                  },
                                ),
                                const Spacer(),
                                OtpTimerButton(
                                  controller: widget.controller,
                                  onPressed: () {
                                    widget.controller.startTimer();
                                    context.read<LoginUserBloc>().add(
                                        FirstLoginEvent(email: widget.emailController.text)
                                    );
                                  },
                                  text: const Text('Resend OTP'),
                                  duration: 120,
                                ),
                              ],
                            ),
                          ),
                      )
                  );
                },
              );


          } else {
            WebToast(
              title: 'Sent code to your email failed.',
              backgroundColor: Color(0xFFC20808),
              icon: Icons.error,
            ).show(context);
          }
        }else if (state.status.isError) {
          WebToast(
            title: 'Error.',
            backgroundColor: Color(0xFFC20808),
            icon: Icons.error,
          ).show(context);
        }


      },
      child: ClipRRect(
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

                if(widget.state == 0) {

                  print(widget.emailController.text);

                  context.read<LoginUserBloc>().add(FirstLoginEvent(email: widget.emailController.text));

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
      ),
    );
  }
}
