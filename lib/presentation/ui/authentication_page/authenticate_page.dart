import 'dart:async';
import 'dart:ui';
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
import '../main_page/main_page.dart';

class AuthenticatePage extends StatefulWidget {

  final String pageName = "AuthenticatePage";
  static String routeName = "AuthenticatePage";

  AuthenticatePage({super.key});

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

  late AnimationController _heartController;

  late List<TextEditingController?> verificationCodeController;
  OtpTimerButtonController controller = OtpTimerButtonController();

  int _state = 0;

  late List<Map<String, dynamic>> iconAnimations;

  @override
  void initState() {
    super.initState();

    const quick = Duration(milliseconds: 500);
    _heartController = AnimationController(duration: quick, vsync: this);

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(parent: controller1, curve: Curves.easeInOut),
    )..addStatusListener((status) => _animationStatusListener(controller1, status));

    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(parent: controller1, curve: Curves.easeInOut),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animation3 = Tween<double>(begin: .41, end: .38).animate(
      CurvedAnimation(parent: controller2, curve: Curves.easeInOut),
    )..addStatusListener((status) => _animationStatusListener(controller2, status));

    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(parent: controller2, curve: Curves.easeInOut),
    );

    // Start animations after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        controller1.forward();
        controller2.forward();
      }
    });

    // تعریف لیست آیکون‌ها
    iconAnimations = [
      {
        "topValue": .15,
        "leftValue": .5,
        "iconSize": 80.0,
        "animation": animation2,
        "icon": MyFlutterApp.music,
      },
      {
        "topValue": .2,
        "leftValue": .05,
        "iconSize": 110.0,
        "animation": animation1,
        "icon": MyFlutterApp.music,
      },
      {
        "topValue": .3,
        "leftValue": .05,
        "iconSize": 110.0,
        "animation": animation1,
        "icon": MyFlutterApp.music_note,
      },
      // سایر آیکون‌ها را در اینجا اضافه کنید.
    ];

    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) controller1.forward();
    });

    if (mounted) controller2.forward();
  }

  void _animationStatusListener(AnimationController controller, AnimationStatus status) {
    if (mounted) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    }
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
        body: BlocListener <UserBloc, UserState>(
          listener: (context, state){

            if(state.status.isSuccess){
              Fluttertoast.showToast(
                  msg: "Code sent to your email successfully .",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 3,
                  backgroundColor: const Color(
                      0xFF00B01E).withValues(alpha: 0.2),
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }else if(state.status.isError){
              Fluttertoast.showToast(
                  msg: "Code sent to your email Field .",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 3,
                  backgroundColor: const Color(
                      0xFFC20808).withValues(alpha: 0.2),
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }

          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: animation1,
                    builder: (context, child) {
                      return MusicIconAnimation(
                        topValue: animation1.value,
                        leftValue: .5,
                        iconSize: 80,
                        animation: animation2,
                        icon: MyFlutterApp.music,
                      );
                    },
                  ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 50,
                            fontFamily: "Salsa",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 4,
                          ),
                        ),
                        SizedBox(height: size.height / 8,),
                        component1(
                            Icons.email_outlined, 'Email...', false, true, emailController, emailFormKey),
                        const SizedBox(height: 10,),
                        component2(
                          'LOG IN',
                          2.58,
                          emailFormKey
                        ),
                        const SizedBox(height: 10,),
                        component2(
                          'SIGN UP',
                          2.58,
                          emailFormKey
                        ),
                        const SizedBox(height: 10,),
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
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8),),
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
                fillColor: Colors.white.withValues(alpha: 0.1),
                filled: true,
                prefixIcon: Icon(
                  icon,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                border: InputBorder.none,
                hintMaxLines: 1,
                hintText: hintText,
                hintStyle:
                TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8),),
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
          onTap: () async {

            if (emailFormKey.currentState!.validate()){
              if (_state == 0) {
                animateButton();
                final registerBloc = BlocProvider.of<UserBloc>(context);
                if(string == "SIGN UP"){

                  registerBloc.add(RegisterUserEvent(email: emailController.text));

                }
                else if(string == "LOG IN") {

                  String userExist = await registerBloc.userRepository.userExist(emailController.text);

                  if(userExist != "رکورد با مشخصات وارد شده یافت نشد"){

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

                                    bool isTrue = await registerBloc.userRepository.secondLogin(emailController.text, verificationCode);

                                    if(isTrue){
                                      Fluttertoast.showToast(
                                          msg: "Authentication Success...  Welcome .",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: const Color(
                                              0xFF00B01E).withValues(alpha: 0.2),
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
                                              0xFFC20808).withValues(alpha: 0.2),
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

                  }else{

                    Fluttertoast.showToast(
                        msg: "The user has not registered with the entered email .",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 3,
                        backgroundColor: const Color(
                            0xFFC20808).withValues(alpha: 0.2),
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

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
              string,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8),),
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
