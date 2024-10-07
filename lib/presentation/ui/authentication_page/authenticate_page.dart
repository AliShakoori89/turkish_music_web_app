// presentation/ui/authenticate_page.dart
import 'dart:async';
import 'dart:ui';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/music_icon_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../bloc/user_bloc/bloc.dart';
import '../../bloc/user_bloc/event.dart';
import '../../const/custom_icon/music_icons.dart';
import '../../const/error_internet_connection_page.dart';
import '../main_page/main_page.dart';

class AuthenticatePage extends StatefulWidget {

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

  late List<TextEditingController?> verificationCodeController;
  OtpTimerButtonController controller = OtpTimerButtonController();

  int _state = 0;

  IconData? icon;

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
    // Dispose of UserBloc
    BlocProvider.of<UserBloc>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color(0xff192028),
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state){
            if(mounted){
              if(state.status.isSuccess){
                Fluttertoast.showToast(
                    msg: "Get verification code successfully .",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 3,
                    backgroundColor: const Color(
                        0xFF00B01E).withOpacity(0.2),
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }else if(state.status.isError){
                Fluttertoast.showToast(
                    msg: "Get verification code Field .",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 3,
                    backgroundColor: const Color(
                        0xFFC20808).withOpacity(0.2),
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            }
          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  MusicIconAnimation(topValue: .15, leftValue: .5, iconSize: 80, animation: animation2, icon: MyFlutterApp.music,),
                  MusicIconAnimation(topValue: .2, leftValue: .05, iconSize: 110.0, animation: animation1, icon: MyFlutterApp.music,),
                  MusicIconAnimation(topValue: .3, leftValue: .05, iconSize: 110.0, animation: animation1, icon: MyFlutterApp.music_note),
                  MusicIconAnimation(topValue: .3, leftValue: .8, iconSize: 50.0, animation: animation3, icon: MyFlutterApp.music_note),
                  MusicIconAnimation(topValue: .1, leftValue: .8, iconSize: 50.0, animation: animation2, icon: Icons.music_note_outlined),
                  MusicIconAnimation(topValue: .8, leftValue: .9, iconSize: 50.0, animation: animation2, icon: MyFlutterApp.music_note),
                  MusicIconAnimation(topValue: -.1, leftValue: .4, iconSize: 90.0, animation: animation3, icon: MyFlutterApp.music),
                  MusicIconAnimation(topValue: .2, leftValue: .2, iconSize: 70.0, animation: animation2, icon: MyFlutterApp.music_note),
                  MusicIconAnimation(topValue: .5, leftValue: .6, iconSize: 70.0, animation: animation1, icon: MyFlutterApp.music_note),
                  MusicIconAnimation(topValue: .2, leftValue: .25, iconSize: 100.0, animation: animation3, icon: Icons.music_note_outlined),
                  MusicIconAnimation(topValue: -.1, leftValue: .001, iconSize: 70.0, animation: animation3, icon: MyFlutterApp.music),
                  MusicIconAnimation(topValue: .3, leftValue: .1, iconSize: 160.0, animation: animation1, icon: Icons.music_note_outlined),
                  MusicIconAnimation(topValue: -.25, leftValue: .9, iconSize: 70.0, animation: animation3, icon: MyFlutterApp.music_note),
                  MusicIconAnimation(topValue: .2, leftValue: .5, iconSize: 70.0, animation: animation3, icon: MyFlutterApp.music),
                  MusicIconAnimation(topValue: .7, leftValue: .5, iconSize: 70.0, animation: animation2, icon: Icons.music_note_outlined),
                  MusicIconAnimation(topValue: .4, leftValue: .6, iconSize: 70.0, animation: animation1, icon: MyFlutterApp.music),
                  MusicIconAnimation(topValue: .5, leftValue: .5, iconSize: 60.0, animation: animation2, icon: Icons.music_note_outlined),
                  MusicIconAnimation(topValue: .2, leftValue: .6, iconSize: 100.0, animation: animation3, icon: Icons.music_note_outlined),
                  MusicIconAnimation(topValue: .2, leftValue: .6, iconSize: 80.0, animation: animation2, icon: Icons.music_note_outlined),
                  MusicIconAnimation(topValue: .7, leftValue: .7, iconSize: 80.0, animation: animation2, icon: Icons.music_note_outlined),
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
                                fontFamily: "Salsa",
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
                            children: [
                              component1(
                                  Icons.email_outlined, 'Email...', false, true, emailController, emailFormKey),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: component2(
                                          'LOG IN',
                                          2.58,
                                          emailFormKey
                                      )
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: component2(
                                      'SIGN UP',
                                      2.58,
                                      emailFormKey,
                                    ),
                                  )

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
          ),
        )
    );
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail,
      TextEditingController controller, GlobalKey<FormState> emailFormKey) {
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
              textAlignVertical: TextAlignVertical.center,
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
      if (mounted) { // Check if the widget is still mounted before updating the state
        setState(() {
          _state = 0;
        });
      }
    });
  }
}
