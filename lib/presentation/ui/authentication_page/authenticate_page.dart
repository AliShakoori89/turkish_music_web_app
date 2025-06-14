import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/login_button.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/register_button.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_toast.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/music_icon_animation.dart';
import '../../bloc/user_bloc/login_user_bloc/bloc.dart';
import '../../bloc/user_bloc/login_user_bloc/state.dart';
import '../../const/custom_icon/music_icons.dart';
import '../../helpers/widgets/customTextField.dart';

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
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
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
                Center(
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
                      CustomTextField(
                        icon: Icons.email_outlined,
                        hintText: 'Email...',
                        isEmail: true,
                        isPassword: false,
                        controller: emailController,
                        emailFormKey: emailFormKey,
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LoginButton(
                                buttonTitle: 'LOGIN',
                                width: 2.58,
                                emailFormKey: emailFormKey,
                                emailController: emailController,
                                state: _state,
                                controller: controller),
                            const SizedBox(height: 10,),
                            RegisterButton(
                                buttonTitle: 'SIGN UP',
                                width: 2.58,
                                emailFormKey: emailFormKey,
                                emailController: emailController,
                                state: _state,
                                controller: controller),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
