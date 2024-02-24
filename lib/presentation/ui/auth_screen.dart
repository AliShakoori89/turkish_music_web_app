import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../bloc/user_bloc/bloc.dart';
import '../bloc/user_bloc/event.dart';
import '../const/constants.dart';
import '../helpers/widgets/login_form.dart';
import '../helpers/widgets/sign_up_form.dart';
import '../helpers/widgets/social_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {

  bool _isShowSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;
  final registrationEmailFormKey = GlobalKey<FormState>();
  final firstLoginEmailFormKey = GlobalKey<FormState>();
  String? email;
  int state = 0;

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Stack(
                children: [
                  // login screen
                  AnimatedPositioned(
                    duration: defaultDuration,
                    width: width * 0.88,
                    height: height,
                    left: _isShowSignUp ? -width * 0.76 : 0,
                    child: Container(
                      color: loginBg,
                      child: LoginForm(
                          emailFormKey: firstLoginEmailFormKey),
                    ),
                  ),

                  // signUp screen
                  AnimatedPositioned(
                    duration: defaultDuration,
                    left: _isShowSignUp ? width * 0.12 : width * 0.88,
                    width: width * 0.88,
                    height: height,
                    child: Container(
                      color: signUpBg,
                      child: SignUpForm(
                          emailFormKey: registrationEmailFormKey
                      ),
                    ),
                  ),

                  // logo
                  AnimatedPositioned(
                    // left: 0,
                    duration: defaultDuration,
                    width: width,
                    right: _isShowSignUp ? -width * 0.06 : width * 0.06,
                    top: context.height * 0.2,height: context.height * 0.15, // 10%
                    child: Image.asset('assets/logo/tMusic.png',
                    ),
                  ),

                  // social media
                  AnimatedPositioned(
                    duration: defaultDuration,
                    // left: 0,
                    width: width,
                    right: _isShowSignUp ? -width * 0.06 : width * 0.06,
                    bottom: context.height * 0.1, // 10%
                    child: const SocialButtons(),
                  ),

                  //login text animation
                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: _isShowSignUp
                        ? context.height / 2 - 80
                        : context.height * 0.85, //30%
                    left: _isShowSignUp
                        ? 0
                        : width * 0.44 - 80, // container width is 160 / 2 = 80
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _isShowSignUp ? Colors.white : Colors.white70,
                        fontSize: _isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Transform.rotate(
                        angle: -_animationTextRotate.value * pi / 180,
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_isShowSignUp) {
                                updateView();

                              } else {
                                // login screen appear

                              }



                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding * 0.75),
                            width: 160,
                            child: const Text(
                              'LOG IN',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: context.height * 0.24, //30%
                    left: _isShowSignUp ? width * 0.44 - 80 + width * 0.33 - 80 : width * 0.44 - 80,
                    right: _isShowSignUp ? width * 0.44 - 80 : width * 0.44 - 80 + width * 0.33 - 80,// container width is 160 / 2 = 80
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      child: InkWell(
                        onTap: () {

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75),
                          width: 160,
                          child: ElevatedButton(
                              onPressed: (){

                                if(_isShowSignUp){
                                  if (registrationEmailFormKey.currentState!.validate()){
                                    if (state == 0) {
                                      animateButton();
                                      final registerBloc = BlocProvider.of<UserBloc>(context);
                                      registerBloc.add(RegisterUserEvent(email: email!));
                                    }
                                  }
                                }else{
                                  if (firstLoginEmailFormKey.currentState!.validate()){
                                    if (state == 0) {

                                      animateButton();
                                      final registerBloc = BlocProvider.of<UserBloc>(context);
                                      registerBloc.add(FirstLoginEvent(email: email!));
                                    }
                                  }
                                }


                              }, 
                              child: const Text("Submit")),
                        ),
                      )
                    ),
                  ),

                  //signUp text animation
                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: !_isShowSignUp
                        ? context.height / 2 - 80
                        : context.height * 0.85, //30%
                    right: _isShowSignUp
                        ? width * 0.44 - 80
                        : 0, // width container is 160 / 2 = 80
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _isShowSignUp ? Colors.white70 : Colors.white,
                        fontSize: !_isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Transform.rotate(
                        angle: (90 - _animationTextRotate.value) * pi / 180,
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {

                              if (!_isShowSignUp) {
                                updateView();

                              } else {
                                // login screen appear

                              }



                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding * 0.75),
                            width: 160,
                            child: const Text(
                              'SIGN UP',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }));
  }

  Widget setUpButtonChild(String title) {
    if (state == 0) {
      return Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    }
    else if (state == 1) {
      return const SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    else {
      return Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    }
  }

  void animateButton() {
    setState(() {
      state = 1;
    });

    Timer(const Duration(milliseconds: 3300), () {
      setState(() {
        state = 0;
      });
    });
  }
}
