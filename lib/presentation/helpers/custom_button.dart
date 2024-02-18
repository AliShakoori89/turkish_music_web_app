import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:turkish_music_app/presentation/ui/main_page/input_verification_code.dart';
import '../bloc/register_user_bloc/bloc.dart';
import '../bloc/register_user_bloc/event.dart';
import '../bloc/register_user_bloc/state.dart';

class CustomButton extends StatelessWidget {
   CustomButton({
     super.key,
     this.emailFormKey,
     required this.buttonName,
     this.email});

    GlobalKey<FormState>? emailFormKey;
    final String buttonName;
    String? email;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.05,
        left: MediaQuery.of(context).size.width * 0.05
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15),
        ),
        onPressed: () {
          final registerBloc = BlocProvider.of<RegisterBloc>(context);

          if (emailFormKey!.currentState!.validate()) {

            if(buttonName == "Sign Up"){

              registerBloc.add(RegisterUserEvent(email: email!));



              // BlocBuilder<RegisterBloc, RegisterState>(
              //     builder: (context, state){
              //
              //       String otpCode = state.otpCode;
              //
              //        return Dialog(
              //          child: Padding(
              //            padding: const EdgeInsets.all(8.0),
              //            child: Column(
              //              mainAxisSize: MainAxisSize.min,
              //              mainAxisAlignment: MainAxisAlignment.center,
              //              children: <Widget>[
              //                Padding(
              //                  padding: const EdgeInsets.only(
              //                      top: 10,
              //                      bottom: 20
              //                  ),
              //                  child: Expanded(
              //                    child: Row(
              //                      children: [
              //                        const Text("Enter code when sent to "),
              //                        Text("${email?.substring(0,3)}...${email?.substring(email!.length - 5)} :",
              //                            style: const TextStyle(
              //                              fontWeight: FontWeight.bold,
              //                            )),
              //                      ],
              //                    ),
              //                  ),
              //                ),
              //                const SizedBox(height: 15),
              //                OtpTextField(
              //                  numberOfFields: 6,
              //                  borderColor: Colors.white,
              //                  //set to true to show as box or false to show as dash
              //                  showFieldAsBox: true,
              //                  //runs when a code is typed in
              //                  onCodeChanged: (String code) {
              //                    //handle validation or checks here
              //                  },
              //                  //runs when every textfield is filled
              //                  onSubmit: (String verificationCode){
              //                    showDialog(
              //                        context: context,
              //                        builder: (context){
              //                          return AlertDialog(
              //                            title: const Text("Verification Code",
              //                              style: TextStyle(color: Colors.white),),
              //                            content: Text('Code entered is $verificationCode'),
              //                          );
              //                        }
              //                    );
              //                  }, // end onSubmit
              //                ),
              //                const SizedBox(height: 20),
              //                Row(
              //                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                  children: [
              //                    TextButton(
              //                      onPressed: () {
              //                        registerBloc.add(
              //                            RegisterUserViaOTPCodeEvent(email: email!, otpCode: otpCode));
              //                        Navigator.pop(context);
              //                      },
              //                      child: const Text('Submit'),
              //                    ),
              //                    TextButton(
              //                      onPressed: () {
              //                        Navigator.pop(context);
              //                      },
              //                      child: const Text('Close'),
              //                    ),
              //                  ],
              //                ),
              //              ],
              //            ),
              //          ),
              //        );
              //     },
              // );

            } else if(buttonName == "Sign In"){

              registerBloc.add(RegisterUserViaOTPCodeEvent(email: email!));
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InputVerificationCode(email: email!),
                ),
              );
            }

          }
        },
        child: Text(buttonName,
          style: const TextStyle(
              color: Colors.white
          ),),
      ),
    );
  }
}
