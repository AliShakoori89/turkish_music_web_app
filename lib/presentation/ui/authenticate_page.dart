import 'dart:async';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_icon/gradient_icon.dart';
import '../bloc/user_bloc/bloc.dart';
import '../bloc/user_bloc/event.dart';
import '../const/custom_icon/music_icons.dart';

class AuthenticatePage extends StatefulWidget {
  const AuthenticatePage({super.key});

  @override
  State<AuthenticatePage> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> with TickerProviderStateMixin {

  final emailController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();

  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  late Animation<double> _heartAnimation;
  late AnimationController _heartController;

  int _state = 0;

  @override
  void initState() {
    super.initState();

    const quick = Duration(milliseconds: 500);
    final scaleTween = Tween(begin: 0.0, end: 1.0);
    _heartController = AnimationController(duration: quick, vsync: this);
    _heartAnimation = scaleTween.animate(
      CurvedAnimation(
        parent: _heartController,
        curve: Curves.elasticOut,
      ),
    );

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    Timer(const Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color(0xff192028),
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  top: size.height * (animation2.value + .15),
                  left: size.width * .5,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music_note,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 80.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .27),
                  left: size.width * .05,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 110.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .2),
                  left: size.width * .8,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music_note,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 50.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .1),
                  left: size.width * .8,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music_note,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 50.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .8),
                  left: size.width * .8,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music_note,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 50.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .25),
                  left: size.width * .4,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 90.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .2),
                  left: size.width * .2,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music_note,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 70.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .6),
                  left: size.width * .6,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music_note,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 70.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .58),
                  left: size.width * .21,
                  child: const GradientIcon(
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    icon: Icons.music_note_outlined,
                    size: 100.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .25),
                  left: size.width * .001,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 70.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .37),
                  left: size.width * .1,
                  child: const GradientIcon(
                    icon: Icons.music_note_outlined,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 160.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .1),
                  left: size.width * .9,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music_note,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 70.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .5),
                  left: size.width * .5,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music_note,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 70.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .7),
                  left: size.width * .5,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music_note,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 70.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .4),
                  left: size.width * .5,
                  child: const GradientIcon(
                    icon: MyFlutterApp.music,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 70.0,
                  ),
                ),
                Positioned(
                  top: size.height * .5,
                  left: size.width * (animation2.value + .5),
                  child: const GradientIcon(
                      icon: Icons.music_note_outlined,
                      gradient: LinearGradient(
                        colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      size: 60.0),
                ),
                Positioned(
                  top: size.height * (animation2.value + .35),
                  left: size.width * 0.01,
                  child: const GradientIcon(
                    icon: Icons.music_note_outlined,
                    gradient: LinearGradient(
                      colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 120.0,
                  ),
                ),
                Positioned(
                  top: size.height * (animation2.value + .2),
                  left: size.width * .60,
                  child: const GradientIcon(
                      icon: Icons.music_note_outlined,
                      gradient: LinearGradient(
                        colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      size: 100.0),
                ),
                Positioned(
                  top: size.height * (animation2.value + .7),
                  left: size.width * .7,
                  child: const GradientIcon(
                      icon: Icons.music_note_outlined,
                      gradient: LinearGradient(
                        colors: [Color(0xffb188ef), Color(0xff5b07bb)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      size: 80.0),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      right: 35,
                      left: 35
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * .1),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              wordSpacing: 4,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            component1(
                                Icons.email_outlined, 'Email...', false, true, emailController, emailFormKey),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                component2(
                                  'LOG IN',
                                    2.58,
                                  emailFormKey
                                ),
                                SizedBox(width: size.width / 20),
                                component2(
                                  'SIGN UP',
                                  2.58,
                                  emailFormKey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            component2(
                              'Login with google Account',
                              2,
                              emailFormKey,
                            ),
                            SizedBox(height: size.height * .05),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail,
      TextEditingController controller, GlobalKey<FormState> emailFormKey) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(

          child: Form(
            key: emailFormKey,
            child: TextFormField(
              controller: controller,
              style: TextStyle(color: Colors.white.withOpacity(.8)),
              cursorColor: Colors.white,
              obscureText: isPassword,
              keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter email';
                }
                else if (EmailValidator.validate(value)){
                  return null ;
                }
                return "Enter a valid email";
              },
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(.05),
                filled: true,
                prefixIcon: Icon(
                  icon,
                  color: Colors.white.withOpacity(.7),
                ),
                border: InputBorder.none,
                hintMaxLines: 1,
                hintText: hintText,
                hintStyle:
                TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, GlobalKey<FormState> emailFormKey) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: (){

            if (emailFormKey.currentState!.validate()){
              if (_state == 0) {
                animateButton();
                final registerBloc = BlocProvider.of<UserBloc>(context);
                if(string == "SIGN UP"){

                  registerBloc.add(RegisterUserEvent(email: emailController.text));

                }
                else if(string == "LOG IN"){
                  registerBloc.add(FirstLoginEvent(email: emailController.text));
                }
              }
            }

          },
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Colors.white.withOpacity(.8)),
            ),
          ),
        ),
      ),
    );
  }

  Widget setUpButtonChild(String title) {
    if (_state == 0) {
      return Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    }
    else if (_state == 1) {
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
      _state = 1;
    });

    Timer(const Duration(milliseconds: 3300), () {
      setState(() {
        _state = 0;
      });
    });
  }
}
