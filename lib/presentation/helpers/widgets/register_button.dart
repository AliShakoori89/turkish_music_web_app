import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/register_user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/register_user_bloc/event.dart';
import '../../bloc/user_bloc/register_user_bloc/state.dart';
import '../../ui/main_page/main_page.dart';
import 'custom_toast.dart';

class RegisterButton extends StatefulWidget {

  RegisterButton({
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
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {

  late List<TextEditingController?> verificationCodeController;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    return BlocListener<RegisterUserBloc, RegisterUserState>(
        listener: (context, state) {
          if (state.status.isLoading) {
            Center(child: CircularProgressIndicator());
          } else if (state.status.isSuccess) {
            if (state.requestPublic) {

              WebToast(
                title: 'Registration successful.',
                backgroundColor: Color(0xFF00B01E),
                icon: Icons.check_circle,
              ).show(context);

              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            } else {

              WebToast(
                title: 'The entered email is registered \nplease login.',
                backgroundColor: Color(0xFFC20808),
                icon: Icons.error,
              ).show(context);
            }

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

                  if (widget.state == 0) {

                      context.read<RegisterUserBloc>().add(RegistrationUserEvent(email: widget.emailController.text));

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
