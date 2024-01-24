import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class SignUpTextButton extends StatelessWidget {
  const SignUpTextButton({super.key, 
    required this.emailFormKey,
    required this.email});

  final GlobalKey<FormState> emailFormKey;
  final String email;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          if (emailFormKey.currentState!.validate()) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 20
                        ),
                        child: Expanded(
                          child: Row(
                            children: [
                              const Text("Enter code when sent to "),
                              Text("${email.substring(0,3)}...${email.substring(email.length - 5)} :",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      OtpTextField(
                        numberOfFields: 6,
                        borderColor: Colors.white,
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          //handle validation or checks here
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode){
                          showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: const Text("Verification Code",
                                  style: TextStyle(color: Colors.white),),
                                  content: Text('Code entered is $verificationCode'),
                                );
                              }
                          );
                        }, // end onSubmit
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Submit'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
            }
        },
        child: const Text("Sign up",
          style: TextStyle(
              color: Colors.blue
          ),));
  }
}


